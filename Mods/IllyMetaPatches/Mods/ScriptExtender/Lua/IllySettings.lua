
-- The raw static data is stored in shorts
-- raw value + 8 = attribute value

-- This determines not just the defaults,
-- but also what companions start with.
-- This is probably why Larian made wizards default
-- to 12 charisma...

-- This one in particular is settable easily via lsx
AbilityDistributionPresets = {
    ["Barbarian"] = {
        ["Strength"]     = 14,  ["Dexterity"] = 14, ["Constitution"] = 13,
        ["Intelligence"] = 10,  ["Wisdom"]    = 12, ["Charisma"]     = 10
    },
    ["Bard"] = {
        ["Strength"]     = 8 ,  ["Dexterity"] = 15, ["Constitution"] = 14,
        ["Intelligence"] = 10,  ["Wisdom"]    = 10, ["Charisma"]     = 14
    },
    ["Cleric"] = {
        ["Strength"]     = 10,  ["Dexterity"] = 15, ["Constitution"] = 14,
        ["Intelligence"] = 8 ,  ["Wisdom"]    = 15, ["Charisma"]     = 8
    },
    ["Druid"] = {
        ["Strength"]     = 14,  ["Dexterity"] = 14, ["Constitution"] = 12,
        ["Intelligence"] = 10,  ["Wisdom"]    = 14, ["Charisma"]     = 8
    },
    ["Fighter"] = {
        ["Strength"]     = 14,  ["Dexterity"] = 14, ["Constitution"] = 15,
        ["Intelligence"] = 12,  ["Wisdom"]    = 8 , ["Charisma"]     = 8
    },
    ["Monk"] = {
        ["Strength"]     = 14,  ["Dexterity"] = 15, ["Constitution"] = 14,
        ["Intelligence"] = 9 ,  ["Wisdom"]    = 12, ["Charisma"]     = 8
    },
    ["Paladin"] = {
        ["Strength"]     = 15,  ["Dexterity"] = 10, ["Constitution"] = 14,
        ["Intelligence"] = 8 ,  ["Wisdom"]    = 10, ["Charisma"]     = 14
    },
    -- this one is odd because of jaheira and minsc, todo mod their origin progressions
    -- and make this nicer for players
    ["Ranger"] = {
        ["Strength"]     = 14,  ["Dexterity"] = 14, ["Constitution"] = 13,
        ["Intelligence"] = 9 ,  ["Wisdom"]    = 14, ["Charisma"]     = 8
    },
    ["Rogue"] = {
        ["Strength"]     = 8 ,  ["Dexterity"] = 15, ["Constitution"] = 15,
        ["Intelligence"] = 8 ,  ["Wisdom"]    = 15, ["Charisma"]     = 8
    },
    ["Sorcerer"] = {
        ["Strength"]     = 8 ,  ["Dexterity"] = 14, ["Constitution"] = 15,
        ["Intelligence"] = 10,  ["Wisdom"]    = 10, ["Charisma"]     = 14
    },
    ["Warlock"] = {
        ["Strength"]     = 8 ,  ["Dexterity"] = 14, ["Constitution"] = 15,
        ["Intelligence"] = 10,  ["Wisdom"]    = 10, ["Charisma"]     = 14
    },
    ["Wizard"] = {
        ["Strength"]     = 8 ,  ["Dexterity"] = 15, ["Constitution"] = 14,
        ["Intelligence"] = 14,  ["Wisdom"]    = 12, ["Charisma"]     = 8
    },
}

-- This is just the +2, then +1 respectively.
AbilityDefaultValues = {
    ["Barbarian"] = {"Strength"     , "Constitution"},
    ["Bard"     ] = {"Charisma"     , "Dexterity"   },
    ["Cleric"   ] = {"Wisdom"       , "Dexterity"   },
    ["Druid"    ] = {"Wisdom"       , "Dexterity"   },
    ["Fighter"  ] = {"Strength"     , "Constitution"},
    ["Monk"     ] = {"Strength"     , "Dexterity"   },
    ["Paladin"  ] = {"Charisma"     , "Strength"    },
    ["Ranger"   ] = {"Dexterity"    , "Constitution"},
    ["Rogue"    ] = {"Dexterity"    , "Constitution"},
    ["Sorcerer" ] = {"Charisma"     , "Constitution"},
    ["Warlock"  ] = {"Charisma"     , "Constitution"},
    ["Wizard"   ] = {"Intelligence" , "Dexterity"   },
}

--[[
Guid TableUUID;
Guid OriginUuid;
Guid RaceUuid;
Guid ClassUuid;
Guid SubclassUuid;

]]--

--[[ Other default values:
SkillDefaultValues
PreparedSpellDefaultValues
SpellDefaultValues
EquipmentDefaultValues
]]--

--[[
local data = {}
for _, z in pairs(Ext.StaticData.GetAll("SpellDefaultValues")) do
  local default = Ext.StaticData.Get(z, "SpellDefaultValues")
  data[z] = Ext.Json.Parse(Ext.DumpExport(default))
end
Ext.IO.SaveFile("spellpreps.json", Ext.Json.Stringify(data))
]]--