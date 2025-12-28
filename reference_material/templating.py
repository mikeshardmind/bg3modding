
import pathlib

# Note: This template doesn't actually work out as intended, come back to this another time.

types = ["Slashing","Piercing","Bludgeoning","Acid","Thunder","Necrotic","Fire","Lightning","Cold","Psychic" ,"Poison" ,"Radiant" ,"Force" ,]

template = """
new entry "Interrupt_CollegeOfDueling_AtYourFingertips_{0}"
type "InterruptData"
data "DisplayName" "h09eaf78fg7eb1g4178g99eeg5c6f6ff435b0;1"
data "Description" "h426fd17ag4cfcg44ecgbf3fg47a6679c14ab;1"
data "Icon" "PassiveFeature_BardicInspiration_Attack"
data "InterruptContext" "OnCastHit"
data "InterruptContextScope" "Self"
data "Container" "YesNoDecision"
data "Conditions" "Self(context.Source,context.Observer) and not Self() and IsHit() and IsCantrip() an not IsKillingBlow() and SpellDamageTypeIs(DamageType.{0})"
data "Properties" "IF(IsCantrip()):DealDamage(LevelMapValue(CollegeOfDueling_AYF),{0},Magical)"
data "Cost" "BardicInspiration:1"
data "Stack" "ColegeOfDueling"
data "Cooldown" "OncePerTurn"
data "InterruptDefaultValue" "Enabled;Ask"
data "EnableCondition" "not HasStatus('SG_Polymorph') or HasAnyStatus({{'SG_Disguise','WILDSHAPE_STARRY_ARCHER_PLAYER','WILDSHAPE_STARRY_CHALICE_PLAYER','WILDSHAPE_STARRY_DRAGON_PLAYER'}});"
data "EnableContext" "OnStatusApplied;OnStatusRemoved"
""".strip()

nm_template = "UnlockInterrupt(Interrupt_CollegeOfDueling_AtYourFingertips_{0})"

write_path = pathlib.Path(__file__).parent.with_name("Mods") / "CollegeOfDueling" / "Public" / "CollegeOfDueling"


write_path = write_path / "Stats" / "Generated" / "Data" / "CollegeOfDueling_GeneratedInterrupts.txt"


if __name__ == "__main__":
    with write_path.open(mode="w") as fp:
        fp.write("// This file was templated. See source repo for script.\n\n")
        fp.write("\n\n".join(template.format(t) for t in types))

    print("Use the following for the unlock", ";".join(nm_template.format(t) for t in types), sep="\n")