---@class SelectorType
---@field Ability string
---@field ActionResource string
---@field ClassUUID string
---@field CooldownType string
---@field PrepareType string
---@field SpellUUID string
---@field SelectorId string


local SelectorBase = {
    Ability = "None",
    ActionResource = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ClassUUID = "00000000-0000-0000-0000-000000000000",
    CooldownType = "Default",
    PrepareType = "Unknown",
    SpellUUID = "",
    SelectorId = " ",
}

local RitualSelectorBase = {
    Ability = "None",
    ActionResource = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ClassUUID = "00000000-0000-0000-0000-000000000000",
    CooldownType = "Default",
    PrepareType = "AlwaysPrepared",
    SpellUUID = "",
    SelectorId = " ",
}


---@param always_prepared boolean
---@return SelectorType
local function new_selector(always_prepared)
    local ret = {}
    for k, v in pairs(always_prepared and RitualSelectorBase or SelectorBase) do
        ret[k] = v
    end
    return ret
end

---@class config
---@field enabled boolean
---@field with_scroll_learning boolean
---@field rituals_always_prepared boolean
---@field disable_preparation_requirements boolean


local defaultConfig = {
    enabled = true,
    with_scroll_learning = false,
    rituals_always_prepared = true,
    disable_preparation_requirements = false,
}

local invalid_config_messages = {
    ["boolean"] = '[RangersPreparation] Invalid entry for key "%s" (expected: true or false) in config file, disabling mod'
}

---@param filename string
---@return config
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


local validated_spells_cache = {}
local has_warned_broken = {}
local has_warned_broken_list = {
    ["IGNORE"] = true
}

local broken_warn_formats = {
    NotSpell = "[RangersPreparation] Spell list %s contained something other than a spell. The bad entry is named %s",
    InvalidSpellLevel = "[RangersPreparation] The spell named %s has an invalid level",
    InvalidSpellContainerID = "[RangersPreparation] The spell named %s has an invalid container ID specified",
    MissingSpell = "[RangersPreparation] Spell list %s contained a spell that isn't defined named %s",
    InvalidSpellName = "[RangersPreparation] Spell list: %s contains an invalid spell name",
    InvalidRitualCosts = "[RangersPreparation] The spell named %s has invalid ritual costs",
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

---@param config config
---@param class_guid string
local function ModifyDescriptionsAndCollectProgressions(config, class_guid)
    local ret_sc = {}
    local ret_mc = {}

    local class_prog_table_ids = {}
    local subclass_prog_table_ids = {}

    local must_prepare = not config.disable_preparation_requirements

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

    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")

        if class_prog_table_ids[pd.TableUUID] ~= nil then
            if pd.IsMulticlass then
                table.insert(ret_mc, pd)
            else
                table.insert(ret_sc, pd)
            end
        end

        if class_prog_table_ids[pd.TableUUID] or subclass_prog_table_ids[pd.TableUUID] then
            for _, this_select in ipairs(pd["AddSpells"]) do
                this_select.PrepareType = "AlwaysPrepared"
            end

        end
    end

    table.sort(ret_mc, function(a, b) return a.Level < b.Level end)
    table.sort(ret_sc, function(a, b) return a.Level < b.Level end)
    return ret_sc, ret_mc
end



-- Matches the removal done by
-- "Use 5e spells with Mystra's Spells" Mod.
-- See article: https://www.nexusmods.com/baldursgate3/articles/1536
-- only used when this mod is present, otherwise we assume the user
-- wants duplicates as options or is handling it themselves.
local known_5e_mystras_duplicates = {
    ["Target_BoomingBladeMove"] = true,
    ["Projectile_Infestation"] = true,
    ["Projectile_MindSilver"] = true,
    ["Target_CreateDestroyMoldEarth"] = true,
    ["Target_ShapeWater_Container"] = true,
    ["Shout_MagicStone"] = true,
    ["Shout_AbsorbElementsSpell"] = true,
    ["Projectile_ChaosBoltNew"] = true,
    ["Zone_CausticBrew"] = true,
    ["Zone_AganazzarScorcher"] = true,
    ["Shout_DustDevil"] = true,
    ["Target_EarthenGrasp"] = true,
    ["Target_SnowballStorm"] = true,
    ["Target_MindWhip"] = true,
    ["Shout_CreateFoodAndWater"] = true,
    ["Shout_MelfsMinuteMeteors"] = true,
    ["Target_SummonFey"] = true,
    ["Shout_WaterWalk"] = true,
    ["Target_ArcaneEyeNew"] = true,
    ["Target_PsychicLance"] = true,
    ["Target_SummonBeholderkin"] = true,
    ["Shout_FarStep"] = true,
    ["Target_SteelWindStrike"] = true,
    ["Target_SummonDraconicSpirit"] = true,
}

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

---@param class_guid string
---@param spell_action_resource string
---@param filename string
---@param Ours table<integer, string>
---@param OursRitual table<integer, string>
function API_ModifyLists(class_guid, spell_action_resource, filename, Ours, OursRitual)

    local config = LoadConfig(filename)
    if config.enabled ~= true then
        return
    end

    local use_mystras_with_5e_loaded = Ext.Mod.IsModLoaded("5d1585fa-973a-5721-8bce-4bfbbc84072a")

    local to_subtract = use_mystras_with_5e_loaded and known_5e_mystras_duplicates or {}

    local seen_lists = {}
    local seen_class_spells = {}

    local prog_data, mc_prog_data = ModifyDescriptionsAndCollectProgressions(config, class_guid)

    local max_spell_lv = 0
    local sl_map = {}

    for _, pd in ipairs(prog_data) do
        local spell_lv = max_spell_lv

        local to_remove = {}
        for idx, this_select in ipairs(pd["SelectSpells"]) do

            if this_select.PrepareType == "Unknown" then
                table.insert(to_remove, idx)
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

        table.sort(to_remove, function (a, b) return a > b end)
        for _, idx in ipairs(to_remove) do
            pd["SelectSpells"][idx] = nil
        end

        if spell_lv > max_spell_lv then
            local norm_select = new_selector(false)
            local ritual_select = new_selector(true)
            norm_select.SpellUUID = Ours[spell_lv]
            ritual_select.SpellUUID = OursRitual[spell_lv]
            norm_select.ActionResource = spell_action_resource
            ritual_select.ActionResource = spell_action_resource
            pd["AddSpells"][#pd["AddSpells"] + 1] = norm_select
            pd["AddSpells"][#pd["AddSpells"] + 1] = ritual_select
            max_spell_lv = spell_lv
            sl_map[pd.Level] = spell_lv
        end
    end

    for _, pd in ipairs(mc_prog_data) do
        local spell_lv = sl_map[pd.Level]
        if spell_lv then
            local norm_select = new_selector(false)
            local ritual_select = new_selector(true)
            norm_select.SpellUUID = Ours[spell_lv]
            ritual_select.SpellUUID = OursRitual[spell_lv]
            norm_select.ActionResource = spell_action_resource
            ritual_select.ActionResource = spell_action_resource
            pd["AddSpells"][#pd["AddSpells"] + 1] = norm_select
            pd["AddSpells"][#pd["AddSpells"] + 1] = ritual_select
        end

        local to_remove = {}
        for idx, this_select in ipairs(pd["SelectSpells"]) do

            if this_select.PrepareType == "Unknown" then
                table.insert(to_remove, idx)
            end
        end
        table.sort(to_remove, function (a, b) return a > b end)
        for _, idx in ipairs(to_remove) do
            pd["SelectSpells"][idx] = nil
        end
    end

    local class_desc = Ext.StaticData.Get(class_guid, "ClassDescription")
    local class_list = Ext.StaticData.Get(class_desc.SpellList, "SpellList")
    local total_list = subtract_setlists(seen_class_spells, to_subtract)

    class_list.Spells = total_list

    local leveled_lists = {
        [1] = {["prep"] = {}, ["ritual"] = {}},
        [2] = {["prep"] = {}, ["ritual"] = {}},
        [3] = {["prep"] = {}, ["ritual"] = {}},
        [4] = {["prep"] = {}, ["ritual"] = {}},
        [5] = {["prep"] = {}, ["ritual"] = {}},
        [6] = {["prep"] = {}, ["ritual"] = {}},
        [7] = {["prep"] = {}, ["ritual"] = {}},
        [8] = {["prep"] = {}, ["ritual"] = {}},
        [9] = {["prep"] = {}, ["ritual"] = {}},
    }

    for _, spellname in ipairs(seen_class_spells) do
        local spell = get_spell_with_validation(spellname, "IGNORE")
        if spell ~= nil then
            if config.rituals_always_prepared and #spell.RitualCosts:match("^%s*(.-)%s*$") > 0 then
                table.insert(leveled_lists[spell.Level]["ritual"], spellname)
            else
                table.insert(leveled_lists[spell.Level]["prep"], spellname)
            end
        end
    end

    for i, data in pairs(leveled_lists) do
        local prep = subtract_setlists(data["prep"], to_subtract)
        local ritual = subtract_setlists(data["ritual"], to_subtract)

        if #prep > 0 then
            local prep_list = Ext.StaticData.Get(Ours[i], "SpellList")
            prep_list.Spells = prep
        end

        if #ritual > 0 then
            local ritual_list = Ext.StaticData.Get(OursRitual[i], "SpellList")
            ritual_list.Spells = ritual
        end
    end

end
