
import itertools
import json
import re
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

def sort_key(s: str) -> tuple[int, str, str]:
    data = spell_data[s]
    return data["Level"], data["DisplayName"], data["OriginalModName"]


player_spells_sorted: list[str] = sorted(player_spell_set, key=sort_key)

sailor_wish_pattern = re.compile(r"^SCWSH\d+$")


with open("raw.csv", mode="w") as fp:
    print("Level", "TechnicalName", "DisplayName", "OriginalModName", "Is on a player spell list", "Is Sailor Wish replica", sep=",", file=fp, flush=True)
    for spell_name, data in spell_data.items():
        level, display, modname = data["Level"], data["DisplayName"], data["OriginalModName"]
        on_list = "Yes" if spell_name in player_spell_set else "No"
        wish = "Yes" if sailor_wish_pattern.match(spell_name) else "No"
        if display:
            print(level, f'"{spell_name}"', f'"{display}"', f'"{modname}"', on_list, wish, sep=",", file=fp, flush=True)


with open("cleaned.csv", mode="w") as fp:
    print("Level", "TechnicalName", "DisplayName", "OriginalModName", sep=",", file=fp, flush=True)
    for spell_name in player_spells_sorted:
        level, display, modname = sort_key(spell_name)
        print(level, spell_name, display, modname, sep=",", file=fp, flush=True)


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
            print(*group, sep=", ", file=fp, flush=True)
            print(file=fp, flush=True)

