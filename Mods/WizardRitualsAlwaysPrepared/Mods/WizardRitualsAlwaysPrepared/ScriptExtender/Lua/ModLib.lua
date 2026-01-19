---@class SelectorType
---@field Ability string
---@field ActionResource string
---@field ClassUUID string
---@field CooldownType string
---@field PrepareType string
---@field SpellUUID string
---@field SelectorId string

local RitualSelectorBase = {
    Ability = "None",
    ActionResource = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ClassUUID = "00000000-0000-0000-0000-000000000000",
    CooldownType = "Default",
    PrepareType = "AlwaysPrepared",
    SpellUUID = "",
    SelectorId = " ",
}


---@return SelectorType
local function new_selector()
    local ret = {}
    for k, v in pairs(RitualSelectorBase) do
        ret[k] = v
    end
    return ret
end

local function CollectProgs(class_guid)
    local ret_sc = {}
    local ret_mc = {}

    local class_prog_table_ids = {}

    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if resourceGuid == class_guid then
            class_prog_table_ids[desc.ProgressionTableUUID] = true
        end
    end

    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")

        if class_prog_table_ids[pd.TableUUID] ~= nil then
            if pd.IsMulticlass then
                table.insert(ret_mc, pd)
            else
                table.insert(ret_sc, pd)
            end
        end
    end

    table.sort(ret_mc, function(a, b) return a.Level < b.Level end)
    table.sort(ret_sc, function(a, b) return a.Level < b.Level end)
    return ret_sc, ret_mc
end


local function subtract_setlists(l1, l2)
    -- creates a new table from the unique sequence values of l1
    -- that are not a key of l2

    local ret = {}
    local seen = {}
    for _, item in pairs(l1) do
        if l2[item] == nil then
            if seen[item] == nil then
                table.insert(ret, item)
                seen[item] = true
            end
        end
    end

    return ret
end

local validated_spells_cache = {}
local has_warned_broken = {}
local has_warned_broken_list = {
    ["IGNORE"] = true
}

local broken_warn_formats = {
    NotSpell = "[WizardRitualsAlwaysPrepared] Spell list %s contained something other than a spell. The bad entry is named %s",
    InvalidSpellLevel = "[WizardRitualsAlwaysPrepared] The spell named %s has an invalid level",
    InvalidSpellContainerID = "[WizardRitualsAlwaysPrepared] The spell named %s has an invalid container ID specified",
    MissingSpell = "[WizardRitualsAlwaysPrepared] Spell list %s contained a spell that isn't defined named %s",
    InvalidSpellName = "[WizardRitualsAlwaysPrepared] Spell list: %s contains an invalid spell name",
    InvalidRitualCosts = "[WizardRitualsAlwaysPrepared] The spell named %s has invalid ritual costs",
}

---@param name string
---@param list_guid string
local function get_spell_with_validation(name, list_guid, debug)
    --- Gets spell data if it exists, that the attributes we need to be valid are valid,
    --- and the spell data does not indicate that the spell is the interior of a container
    --- logs warnings once per spell with broken attributes

    local maybe_spell = validated_spells_cache[name]
    if maybe_spell then
        return maybe_spell
    end

    if type(name) ~= "string" or #name < 1 then
        if debug and has_warned_broken_list[list_guid] == nil then
            Ext.Utils.PrintWarning(broken_warn_formats.InvalidSpellName:format(list_guid))
            has_warned_broken_list[list_guid] = true
        end
        return nil
    end

    if has_warned_broken[name] ~= nil then
        return nil
    end

    local spell = Ext.Stats.Get(name)
    if spell == nil then
        Ext.Utils.PrintWarning(broken_warn_formats.MissingSpell:format(list_guid, name))
        has_warned_broken[name] = true
        return nil
    end

    local ok, modlistype = pcall(function() return spell.ModifierList end)

    if not ok or type(modlistype) ~= "string" or modlistype ~= "SpellData" then
        Ext.Utils.PrintWarning(broken_warn_formats.NotSpell:format(list_guid, name))
        has_warned_broken[name] = true
        return nil
    end

    local ok, container_id = pcall(function() return spell.SpellContainerID end)
    if not ok or type(container_id) ~= "string" then
        Ext.Utils.PrintWarning(broken_warn_formats.InvalidSpellContainerID:format(name))
        has_warned_broken[name] = true
        return nil
    end

    local ok, spell_level = pcall(function() return spell.Level end)
    if not ok or type(spell_level) ~= "number" then
        Ext.Utils.PrintWarning(broken_warn_formats.InvalidSpellLevel:format(name))
        has_warned_broken[name] = true
        return nil
    end

    if #spell.SpellContainerID:match("^%s*(.-)%s*$") ~= 0 then
        return nil
    end

    local ok, ritual_costs = pcall(function() return spell.RitualCosts end)
    if not ok or type(ritual_costs) ~= "string" then
        Ext.Utils.PrintWarning(broken_warn_formats.InvalidRitualCosts:format(name))
        has_warned_broken[name] = true
    end

    validated_spells_cache[name] = spell
    return spell
end

---@param class_guid string
---@param OursRitual table<integer, string>
function API_WizModifyLists(class_guid, OursRitual)

    local seen_lists = {}
    local seen_class_spells = {}

    local prog_data, mc_prog_data = CollectProgs(class_guid)

    local max_spell_lv = 0
    local sl_map = {}

    for _, pd in ipairs(prog_data) do
        local spell_lv = max_spell_lv

        for idx, this_select in ipairs(pd["SelectSpells"]) do

            if this_select.PrepareType == "Unknown" then
                if seen_lists[this_select.SpellUUID] == nil then
                    local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                    if spell_list ~= nil then
                        for _, spell in pairs(spell_list.Spells) do

                            local spell_data = get_spell_with_validation(spell, this_select.SpellUUID)
                            if spell_data ~= nil and spell_data.Level > spell_lv then
                                spell_lv = spell_data.Level
                            end

                            table.insert(seen_class_spells, spell)
                        end
                    end

                end
                seen_lists[this_select.SpellUUID] = true
            end

        end

        if spell_lv > max_spell_lv then
            local ritual_select = new_selector()
            ritual_select.SpellUUID = OursRitual[spell_lv]
            pd["AddSpells"][#pd["AddSpells"] + 1] = ritual_select
            max_spell_lv = spell_lv
            sl_map[pd.Level] = spell_lv
        end
    end

    for _, pd in ipairs(mc_prog_data) do
        local spell_lv = sl_map[pd.Level]
        if spell_lv then
            local ritual_select = new_selector()
            ritual_select.SpellUUID = OursRitual[spell_lv]
            pd["AddSpells"][#pd["AddSpells"] + 1] = ritual_select
        end
    end

    local leveled_ritual_lists = {
        [1] = {},
        [2] = {},
        [3] = {},
        [4] = {},
        [5] = {},
        [6] = {},
        [7] = {},
        [8] = {},
        [9] = {},
    }

    local all_rituals = {}
    local dead_spell_entries = {}

    for _, spellname in ipairs(seen_class_spells) do
        local spell = get_spell_with_validation(spellname, "IGNORE")
        if spell ~= nil then
            if #spell.RitualCosts:match("^%s*(.-)%s*$") > 0 then
                table.insert(leveled_ritual_lists[spell.Level], spellname)
                all_rituals[spellname] = true
            end
        else
            dead_spell_entries[spellname] = true
        end
    end

    for spell_list_id, _ in pairs(seen_lists) do
        local spell_list = Ext.StaticData.Get(spell_list_id, "SpellList")
        local sl = subtract_setlists(spell_list.Spells, all_rituals)
        spell_list.Spells = subtract_setlists(sl, dead_spell_entries)
    end

    for i, data in pairs(leveled_ritual_lists) do
        local ritual = subtract_setlists(data, {})
        if #ritual > 0 then
            local ritual_list = Ext.StaticData.Get(OursRitual[i], "SpellList")
            ritual_list.Spells = ritual
        end
    end

end
