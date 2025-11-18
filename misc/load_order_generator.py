from __future__ import annotations

import dataclasses
import json
import optparse
import pathlib
import sys
import tomllib
from collections import ChainMap
from collections.abc import Generator
from contextlib import nullcontext

from miscutils import DepSorter, CycleDetected

"""
[uuid]
name = str
affinity = int
requires = [str]
patched_by = [str]
patches = [str]
"""


@dataclasses.dataclass(frozen=True, slots=True, eq=False)
class Mod:
    uuid: str
    name: str
    affinity: int = 50
    requires: tuple[str, ...] = ()
    patched_by: tuple[str, ...] = ()
    patches: tuple[str, ...] = ()

    def __lt__(self, other: Mod) -> bool:
        return (self.affinity, self.name) < (other.affinity, other.name)


parser = optparse.OptionParser("usage: %prog [options] file")
# pyright: reportUnknownMemberType=false
parser.add_option("-v", action="count", help="Increase the verbosity")
parser.add_option(
    "--output",
    nargs=1,
    dest="out",
    default="generated_load_order.json",
    help="Where to write the result",
)
parser.add_option(
    "--plaintext",
    action="store_true",
    default=False,
    dest="txt",
    help="Sets an alternative format",
)
parser.add_option(
    "--stdout",
    action="store_true",
    dest="use_stdout",
    default=False,
    help="Writes results to stdout.",
)


def main() -> None:
    opts, args = parser.parse_args()

    if len(args) != 1:
        parser.error("Must provide an input file.")

    if not opts.use_stdout:
        outpath = pathlib.Path(opts.out)
        if outpath.exists():
            parser.error(
                "Not overwriting an existing load order, please specify an output file."
            )
    else:
        outpath = None

    data = parse_mod_data(args[0])

    try:
        results = sort_mods(data)

        if opts.txt:

            content = "\n".join(
                f"{idx:<4d} {m.uuid} {m.name}"
                for idx, m in enumerate(results, 1)
            )
        else:
            order_data = {"Order": [{"UUID": m.uuid, "Name": m.name} for m in results]}
            content = json.dumps(order_data, indent=None, separators=(",", ":"))

        with (
            outpath.open(mode="x", encoding="utf-8") if outpath else nullcontext(sys.stdout)
        ) as fp:
            print(content, file=fp, flush=True)

    except CycleDetected as exc:
        print(
            "Cycle detected: ",
            " -> ".join(m.name for m in exc.args[0]),
            file=sys.stderr,
            sep="\n",
        )
        sys.exit(1)


def parse_mod_data(path: str) -> dict[str, Mod]:
    with open(path, mode="rb") as fp:
        data = tomllib.load(fp)

    return {k: Mod(k, **v) for k, v in data.items()}


def sort_mods(mods: dict[str, Mod]) -> Generator[Mod]:
    sorter: DepSorter[Mod] = DepSorter()

    name_lookup = {m.name: m for m in mods.values()}

    lookup = ChainMap(mods, name_lookup)

    for mod in mods.values():
        deps: list[Mod] = []

        for req_id in mod.requires:
            if req := lookup.get(req_id):
                deps.append(req)
            else:
                print(
                    f"Warn: Missing Requirement {req} of mod: {mod.uuid} {mod.name}",
                    file=sys.stderr,
                )

        sorter.add_dependencies(mod, *deps)
        sorter.add_dependencies(mod, *filter(None, map(lookup.get, mod.patches)))
        sorter.add_dependants(mod, *filter(None, map(lookup.get, mod.patched_by)))

    yield from sorter


if __name__ == "__main__":
    main()
