---@class SelectorType
---@field Ability string
---@field ActionResource string
---@field ClassUUID string
---@field CooldownType string
---@field PrepareType string
---@field SpellUUID string
---@field SelectorId string

Ext.Require("uuids.lua")


local SelectorBase = {
    Ability = "None",
    ActionResource = "e9127b70-22b7-42a1-b172-d02f828f260a",
    ClassUUID = "00000000-0000-0000-0000-000000000000",
    CooldownType = "Default",
    PrepareType = "Unknown",
    SpellUUID = "",
    SelectorId = " ",
}

---@return SelectorType
local function new_selector()
    local ret = {}
    for k, v in pairs(SelectorBase) do
        ret[k] = v
    end
    return ret
end

---@class warlock_config
---@field enabled boolean
---@field with_scroll_learning boolean


local defaultConfig = {
    enabled = true,
    with_scroll_learning = false,
}

local invalid_config_messages = {
    ["boolean"] = 'Invalid entry for key "%s" (expected: true or false) in config file, disabling mod'
}

---@param filename string
---@return warlock_config
local function LoadConfig(filename)
    local file = Ext.IO.LoadFile(filename)
    local ret = file and Ext.Json.Parse(file) or {}

    local needs_rewrite = false

    for key, default in pairs(defaultConfig) do

        local expected_type = type(default)

        if type(ret[key]) == "nil" then
            ret[key] = default
            needs_rewrite = true
        elseif type(ret[key]) ~= expected_type then
            Ext.Utils.PrintWarning(invalid_config_messages[expected_type]:format(key))
            ret.enabled = false
            return ret
        end
    end

    if needs_rewrite then
        local d = Ext.Json.Stringify(ret)
        Ext.IO.SaveFile(filename, d)
    end

    return ret

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
    NotSpell = "[Warlock] Spell list %s contained something other than a spell. The bad entry is named %s",
    InvalidSpellLevel = "The spell named %s has an invalid level",
    InvalidSpellContainerID = "The spell named %s has an invalid container ID specified",
    MissingSpell = "[Warlock] Spell list %s contained a spell that isn't defined named %s",
    InvalidSpellName = "[Warlock] Spell list: %s contains an invalid spell name",
    InvalidRitualCosts = "The spell named %s has invalid ritual costs",
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

---@param config warlock_config
---@param class_guid string
local function ModifyDescriptionsAndCollectProgressions(config, class_guid)
    local ret_sc = {}
    local ret_mc = {}

    local class_prog_table_ids = {}
    local subclass_prog_table_ids = {}

    -- https://www.nexusmods.com/baldursgate3/mods/6770
    -- Xara's Remove Spell Preparation Mod.
    -- We get run after that mod, lets respect user choices here.
    local must_prepare = not Ext.Mod.IsModLoaded("0e8d791a-8338-4aeb-adf0-cd5e68151107")

    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if desc.ParentGuid == class_guid then
            subclass_prog_table_ids[desc.ProgressionTableUUID] = true
            desc.CanLearnSpells = config.with_scroll_learning
            desc.MustPrepareSpells = must_prepare
        end
        if resourceGuid == class_guid then
            class_prog_table_ids[desc.ProgressionTableUUID] = true
            desc.CanLearnSpells = config.with_scroll_learning
            desc.MustPrepareSpells = must_prepare
        end
    end

    for pid, _ in pairs(subclass_prog_table_ids) do
        ret_mc[pid] = {}
        ret_sc[pid] = {}
    end

    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")

        if subclass_prog_table_ids[pd.TableUUID] ~= nil then
            if pd.IsMulticlass then
                table.insert(ret_mc[pd.TableUUID], pd)
            else
                table.insert(ret_sc[pd.TableUUID], pd)
            end
        end

        if class_prog_table_ids[pd.TableUUID] or subclass_prog_table_ids[pd.TableUUID] then
            for _, this_select in ipairs(pd["AddSpells"]) do
                this_select.PrepareType = "AlwaysPrepared"
            end

        end
    end

    for _sid, t in pairs(ret_mc) do
        table.sort(t, function(a, b) return a.Level < b.Level end)
    end
    for _sid, t in pairs(ret_sc) do
        table.sort(t, function(a, b) return a.Level < b.Level end)
    end
    return ret_sc, ret_mc
end

---@param class_guid string
---@param spell_action_resource string
---@param filename string
function API_ModifyLists(class_guid, spell_action_resource, filename)

    local config = LoadConfig(filename)
    if config.enabled ~= true then
        return
    end

    local prog_data, mc_prog_data = ModifyDescriptionsAndCollectProgressions(config, class_guid)

    if #prog_data > 30 then
        Ext.Utils.PrintWarning("Too many warlock subclasses, abandoning warlock prep conversion")
        return
    end

    local next_uuid_index = 1
    local stable_order = {}
    for prog_table_id, _ in pairs(prog_data) do
        table.insert(stable_order, prog_table_id)
    end
    table.sort(stable_order)

    for _, prog_table_id in ipairs(stable_order) do

        local subclass_progdata = prog_data[prog_table_id]
        local mc_subclass_progdata = mc_prog_data[prog_table_id]

        local max_spell_lv = 0
        local sl_map = {}
        local seen_subclass_spells = {}

        local Ours = {}
        for i = 1, 9 do
            Ours[i] = SpellListUUIDs[next_uuid_index]
            next_uuid_index = next_uuid_index + 1
        end


        for _, pd in ipairs(subclass_progdata) do
            local spell_lv = max_spell_lv

            local to_remove = {}
            for idx, this_select in ipairs(pd["SelectSpells"]) do

                if this_select.PrepareType == "Unknown" then


                    local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                    if spell_list ~= nil then
                        local is_leveled = false
                        for _, spell in pairs(spell_list.Spells) do

                            local spell_data = get_spell_with_validation(spell, this_select.SpellUUID)
                            if spell_data ~= nil and spell_data.Level > spell_lv then
                                spell_lv = spell_data.Level
                            end

                            if spell_data and spell_data.Level > 0 then
                                is_leveled = true
                            end

                            table.insert(seen_subclass_spells, spell)
                        end
                        -- warlock cantrips are weird
                        if is_leveled then
                            table.insert(to_remove, idx)
                        else
                            this_select.PrepareType = "AlwaysPrepared"
                        end
                    end

                end

            end

            table.sort(to_remove, function (a, b) return a > b end)
            for _, idx in ipairs(to_remove) do
                pd["SelectSpells"][idx] = nil
            end

            if spell_lv > max_spell_lv then
                local norm_select = new_selector()
                norm_select.SpellUUID = Ours[spell_lv]
                norm_select.ActionResource = spell_action_resource
                pd["AddSpells"][#pd["AddSpells"] + 1] = norm_select
                max_spell_lv = spell_lv
                sl_map[pd.Level] = spell_lv
            end
        end

        for _, pd in ipairs(mc_subclass_progdata) do
            local spell_lv = sl_map[pd.Level]
            if spell_lv then
                local norm_select = new_selector()
                norm_select.SpellUUID = Ours[spell_lv]
                norm_select.ActionResource = spell_action_resource
                pd["AddSpells"][#pd["AddSpells"] + 1] = norm_select
            end

            local to_remove = {}
            for idx, this_select in ipairs(pd["SelectSpells"]) do
                local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                if spell_list ~= nil then
                    local is_leveled = false
                    for _, spell in pairs(spell_list.Spells) do

                        local spell_data = get_spell_with_validation(spell, this_select.SpellUUID)
                        if spell_data ~= nil and spell_data.Level > spell_lv then
                            spell_lv = spell_data.Level
                        end

                        if spell_data and spell_data.Level > 0 then
                            is_leveled = true
                        end
                    end
                    -- warlock cantrips are weird
                    if is_leveled then
                        table.insert(to_remove, idx)
                    else
                        this_select.PrepareType = "AlwaysPrepared"
                    end
                end
            end
            table.sort(to_remove, function (a, b) return a > b end)
            for _, idx in ipairs(to_remove) do
                pd["SelectSpells"][idx] = nil
            end


        end

        local leveled_lists = {
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

        for _, spellname in ipairs(seen_subclass_spells) do
            local spell = get_spell_with_validation(spellname, "IGNORE")
            if spell ~= nil then
                if spell.Level > 0 then
                    table.insert(leveled_lists[spell.Level], spellname)
                end
            end
        end

        for i, data in pairs(leveled_lists) do
            local sl = subtract_setlists(data, {})
            if #sl > 0 then
                local sl_data = Ext.StaticData.Create("SpellList", Ours[i])
                sl_data.Spells = sl
            end
        end
    end
end
