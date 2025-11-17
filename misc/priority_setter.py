"""Changes the priority of a BG3 mod."""

import os
import sys
import getopt
import pathlib
import tempfile
import struct
import typing
import time
import zipfile


# I'm intentionally only supoprting pak version 18 right now.
# can see if I need to deal with older later.

FMT = "<4sIQIBB"
SIG = b"LSPK"


def resolve_path_with_links(path: pathlib.Path, folder: bool = False) -> pathlib.Path:
    """
    Python only resolves with strict=True if the path exists.
    """
    try:
        return path.resolve(strict=True)
    except FileNotFoundError:
        path = resolve_path_with_links(path.parent, folder=True) / path.name
        if folder:
            # python's default is world read/write/traversable... (0o777)
            path.mkdir(mode=0o700)
        else:
            # python's default is world read/writable... (0o666)
            path.touch(mode=0o600)
        return path.resolve(strict=True)


def main():
    try:
        opts, args = getopt.gnu_getopt(sys.argv[1:], "p:")
    except getopt.GetoptError as exc:
        print(exc.msg, file=sys.stderr)
        sys.exit(2)

    if not (opts and args):
        print(f"Usage: {sys.argv[0]} -p n files", file=sys.stderr)
        sys.exit(2)

    priority = 0

    for o in opts:
        _, p = o
        try:
            if len(p) > 3 or not all(char.isdigit() for char in p):
                raise ValueError

            priority = int(p)
            if not (255 >= priority > 0):
                raise ValueError
            if priority > 127:
                print(
                    "Warning: 127 is the normal highest priority supported by other tools.",
                    file=sys.stderr,
                )

        except ValueError:
            print(
                "Priority must be between 0 and 255, range inclusive", file=sys.stderr
            )
            sys.exit(2)

    results = {}

    for file in args:
        if file in results:
            print("Skipping duplicated entry for file: {file}", file=sys.stderr)
            continue
        process_file(priority, file)


def modify_pak(priority: int, io_buffer: typing.IO[bytes], name) -> bool:
    io_buffer.seek(0)
    partial_header = struct.unpack(FMT, io_buffer.read(struct.calcsize(FMT)))
    pak_sig, pak_version, _offset1, _listsize, flags, original_priority = partial_header

    if (pak_sig, pak_version) != (SIG, 18):
        print(f"Skipping file with unexpected pak header: {name}", file=sys.stderr)
        return False

    if original_priority == priority:
        print(f"Already priority {priority}: {io_buffer.name}", file=sys.stderr)
        return False

    io_buffer.seek(21)
    io_buffer.write(struct.pack("<B", priority))

    return True


def modify_zip(priority: int, file: pathlib.Path) -> bool:
    any_modified = False
    desc, temp_path = tempfile.mkstemp()
    tzip = os.fdopen(desc, mode="wb")
    try:
        try:
            with tempfile.SpooledTemporaryFile() as tf:
                with (
                    zipfile.ZipFile(file, mode="r", allowZip64=True) as zipf,
                    zipfile.ZipFile(tzip, mode="w", allowZip64=True) as nz,
                ):
                    for zipinfo in zipf.infolist():
                        if zipinfo.filename.endswith(".pak"):
                            tf.seek(0)
                            tf.truncate()
                            with zipf.open(zipinfo) as pak_file:
                                while chunk := pak_file.read(65536):
                                    tf.write(chunk)

                            if not modify_pak(
                                priority,
                                tf,
                                f"{zipinfo.filename} in archive {file.name}",
                            ):
                                print(
                                    f"Couldn't modify {zipinfo.filename} in archive {file.name}",
                                    file=sys.stderr,
                                )
                            else:
                                any_modified = True

                            tf.seek(0)

                            now = time.localtime()[:6]
                            newinfo = zipfile.ZipInfo(zipinfo.filename, now)
                            newinfo.external_attr = zipinfo.external_attr
                            newinfo.file_size = zipinfo.file_size

                            with nz.open(zipinfo, mode="w") as tr:
                                while chunk := tf.read(65536):
                                    tr.write(chunk)

        except Exception as exc:
            print(f"Error processing zipfile: {file.name} {exc}", file=sys.stderr)
            return False
        finally:
            tzip.close()
        if any_modified:
            os.replace(temp_path, file)
    finally:
        try:
            os.unlink(temp_path)
        except FileNotFoundError:
            pass

    return any_modified


def process_file(priority: int, path: str) -> bool:
    file = pathlib.Path(path)
    file = resolve_path_with_links(file)
    if not file.exists():
        print(f"Skipping not found file: {file}", file=sys.stderr)
        return False

    if file.suffix == ".pak":
        with file.open(mode="+rb") as io_buffer:
            return modify_pak(priority, io_buffer, file.name)
    if file.suffix == ".zip":
        return modify_zip(priority, file)

    return False


if __name__ == "__main__":
    main()
