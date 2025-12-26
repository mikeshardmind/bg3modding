local spells_to_remove = {
    ["Target_Ceremony"] = true,
    ["Shout_ShadowBlade_Spell"] = true,
    ["Shout_HandOfRadiance"] = true,
    ["Target_CreateBonfire"] = true,
    ["Target_MagicStone"] = true,
    ["Target_Infestation"] = true,
    ["Target_Gust"] = true,
    ["Target_GreenFlameBlade"] = true,
    ["Target_MoldEarth"] = true,
    ["Target_ControlFlames"] = true,
    ["Target_UnseenServant"] = true,
    ["Target_ZoneofTruth"] = true,
    ["Zone_GustOfWind"] = true,
    ["Shout_FindTraps"] = true,
    ["Shout_SwordBurst"] = true,
    ["Shout_Thunderclap"] = true,
    ["Target_SilveryBarbs"] = true,
    ["Projectile_SappingSting"] = true,
    ["Target_TrueStrike"] = true,
}

-- todo, generic framework

local sortv_cache = {}
local spell_list_cache = {}

local function generate_sort_key_for_spell(spell_name, spell)
    if sortv_cache[spell_name] ~= nil then
        return true
    end

    local ok, modlistype = pcall(function() return spell.ModifierList end)

    if not ok or type(modlistype) ~= "string" or modlistype ~= "SpellData" then
        Ext.Utils.PrintWarning("Ignoring broken spell entry: " .. spell_name)
        return false
    end

    local translated_name = Ext.Loca.GetTranslatedString(spell.DisplayName)
    local sort_name = (translated_name or "") .. spell_name

    sortv_cache[spell_name] = {["Level"] = spell.Level, ["Name"] = sort_name}
    return true
end

local function sort_func(a, b)

    local lhs = sortv_cache[a]
    local rhs = sortv_cache[b]

    if lhs.Level ~= rhs.Level then
        return lhs.Level > rhs.Level
    end
    return lhs.Name < rhs.Name
end

local function SortSpellWorkingList(working_list)
    local ret = {}
    for spell_name, spell_object in pairs(working_list) do
        if generate_sort_key_for_spell(spell_name, spell_object) then
            table.insert(ret, spell_name)
        end
    end
    table.sort(ret, sort_func)
    return ret

end

function ProgTweaks()
    local bard_prog = "229c98da-2cd1-4a5e-8051-9d90ec7931e7"
    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")

        if pd and pd.TableUUID == bard_prog then
           for _, this_select in ipairs(pd["SelectSpells"]) do
                if this_select.SelectorId == "BardCantrip" then
                    this_select.Amount = this_select.Amount + 1
                end
            end
        end
    end
end

function ModifyLists()

    for _, guid in pairs(Ext.StaticData.GetAll("SpellList")) do
        local spell_list = Ext.StaticData.Get(guid, "SpellList")
        if spell_list_cache[guid] ~= nil then
            if spell_list ~= nil then
                spell_list.Spells = spell_list_cache[guid]
            end
        else
            local checked_names = {}
            local working_list = {}
            if spell_list ~= nil then
                for _, spell_name in pairs(spell_list.Spells) do
                    if checked_names[spell_name] == nil and spells_to_remove[spell_name] == nil then
                        local spell = Ext.Stats.Get(spell_name)
                        if spell ~= nil then
                            working_list[spell_name] = spell
                        end
                    end
                    checked_names[spell_name] = true
                end
            end
            local sorted = SortSpellWorkingList(working_list)
            spell_list_cache[guid] = sorted
            spell_list.Spells = sorted
        end
    end

end