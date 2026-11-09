
import itertools
import json
from pathlib import Path
from typing import TypedDict


class SpellData(TypedDict):
    DisplayName: str
    Level: int
    OriginalModId: str
    OriginalModName: str


CL_PATH = Path(__file__).with_name("class_lists.json")
UNMODLISTS = Path(__file__).with_name("spell_lists_before.json")
SPELLS = Path(__file__).with_name("spell_mods.json")


with CL_PATH.open(mode="rb") as fp:
    class_to_lists: dict[str, list[str]] = json.load(fp)


player_spelllists: set[str] = set()
player_spelllists.update(*class_to_lists.values())

player_spell_set: set[str] = set()

with UNMODLISTS.open(mode="rb") as fp:
    spell_list_to_spells: dict[str, list[str]] = json.load(fp)

for uuid, spell_list in spell_list_to_spells.items():
    if uuid in player_spelllists:
        player_spell_set.update(spell_list)


with SPELLS.open(mode="rb") as fp:
    spell_data: dict[str, SpellData] = json.load(fp)

player_spell_set &= spell_data.keys()

player_spell_set = {
    s for s in player_spell_set
    if "RageMage" not in s
    and "SVMagus" not in s
    and "SVPugilist" not in s
    and "OAPCursed" not in s
}

def sort_key(s: str) -> tuple[int, str, str]:
    data = spell_data[s]

    return data.get("Level", 0), data.get("DisplayName", "???") or "???", data.get("OriginalModName", "???") or "???"


player_spells_sorted: list[str] = sorted(player_spell_set, key=sort_key)


with open("cleaned.csv", mode="w") as fp:
    print("Level", "DisplayName", "OriginalModName", "TechnicalName", sep=",", file=fp, flush=True)
    for spell_name in player_spells_sorted:
        level, display, modname = sort_key(spell_name)
        print(level, display, modname, spell_name, sep=",", file=fp, flush=True)




def group_key(s: str) -> tuple[int, str]:
    data = spell_data[s]
    lv = data["Level"]
    norm_display = data["DisplayName"].strip().lower()
    return lv, norm_display



with open("probable_duplicates.txt", mode="w") as fp:

    for key, gen in itertools.groupby(player_spells_sorted, group_key):
        group = list(gen)
        if len(group) > 1:
            print("----", file=fp, flush=True)
            print(*key, file=fp, flush=True)
            print("Spells: ", end="", file=fp)
            print(*group, sep=", ", file=fp, flush=True)

