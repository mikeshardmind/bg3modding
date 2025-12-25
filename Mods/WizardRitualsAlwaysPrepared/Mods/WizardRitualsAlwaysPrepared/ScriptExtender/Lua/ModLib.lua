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

local stats_data_cache = {}
local function get_stats_with_cache(name)

    local v = stats_data_cache[name]
    if v ~= nil then return v end
    v = Ext.Stats.Get(name)
    stats_data_cache[name] = v
    return v

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

                            local spell_data = get_stats_with_cache(spell)
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
        local spell = get_stats_with_cache(spellname)
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
