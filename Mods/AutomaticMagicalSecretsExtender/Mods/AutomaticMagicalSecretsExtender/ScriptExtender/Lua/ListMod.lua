local bard_guid = "92cd50b6-eb1b-4824-8adb-853e90c34c90"


local magical_secrets_select = {["BardMagicalSecrets"] = true}

---@class (exact) AMSEConfig
---@field debug boolean

local default_config = {
    debug = false
}

local invalid_config_messages = {
    ["boolean"] =
    '[AMSE] Invalid entry for key "%s" (expected: true or false) in config file'
}

---@return AMSEConfig
local function LoadConfig()
    local filename = "AMSEConfig.json"
    local file = Ext.IO.LoadFile(filename)
        local ret = file and Ext.Json.Parse(file) or {}

    local needs_rewrite = false

    for key, default in pairs(default_config) do
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


-- Handles that vanilla there are 3 shield spells
-- We keep the wizard one rather than sorc or warlock
-- because of interactions with potential multiclassing
-- and the base game shield interrupts for sorcerer and warlock
-- both don't interact correctly with arcane ward.
local never_include_as_secrets = {
    ["Shout_Shield_Sorcerer"] = true,
    ["Shout_Shield_Warlock"] = true,
}

---@param s string
---@param sep string
---@param plain boolean?
function StringSplit(s, sep, plain)
    local start = 1
    local done = false
    local function pass(i, j, ...)
        if i then
            local seg = s:sub(start, i - 1)
            start = j + 1
            return seg, ...
        else
            done = true
            return s:sub(start)
        end
    end
    return function()
        if done then
            return
        end
        if sep == '' then
            done = true
            return s
        end
        return pass(s:find(sep, start, plain))
    end
end

---@param s string
---@return string
function Trim(s)
    return s:match("^%s*(.-)%s*$")
end

local sortv_cache = {}
local spell_list_cache = {}

local validated_spells_cache = {}
local has_warned_broken = {}
local has_warned_broken_list = {}
local is_contained_by_container_granting_it = {}

local broken_warn_formats = {
    NotSpell = "[AutomaticMagicalSecretsExtender] Spell list %s contained something other than a spell. The bad entry is named %s",
    InvalidSpellLevel = "[AutomaticMagicalSecretsExtender] The spell named %s has an invalid level",
    InvalidSpellContainerID = "[AutomaticMagicalSecretsExtender] The spell named %s has an invalid container ID specified",
    MissingSpell = "[AutomaticMagicalSecretsExtender] Spell list %s contained a spell that isn't defined named %s",
}

---@param name string
---@param list_guid string
local function get_spell_with_validation(name, list_guid)
    --- Gets spell data if it exists, that the attributes we need to be valid are valid,
    --- and the spell data does not indicate that the spell is the interior of a container
    --- logs warnings once per spell with broken attributes

    local maybe_spell = validated_spells_cache[name]
    if maybe_spell then
        return maybe_spell
    end

    if is_contained_by_container_granting_it[name] then
        return nil
    end

    if type(name) ~= "string" or #name < 1 then
        if has_warned_broken_list[list_guid] == nil then
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

    if #Trim(spell.SpellContainerID) ~= 0 then
        local container = get_spell_with_validation(spell.SpellContainerID, list_guid)
        if container then
            for contained_spellname in StringSplit(container.ContainerSpells, ";", true) do
                if contained_spellname == name then
                    is_contained_by_container_granting_it[name] = true
                    return nil
                end
            end
        end
        return nil
    end

    validated_spells_cache[name] = spell
    return spell

end

---@param name string
---@param list_guid string
local function get_spell_skip_pcalls(name, list_guid)

    local maybe_spell = validated_spells_cache[name]
    if maybe_spell then
        return maybe_spell
    end

    if is_contained_by_container_granting_it[name] then
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

    local modlisttype = spell.ModifierList

    if not (modlisttype and modlisttype ~= "SpellData") then
        Ext.Utils.PrintWarning(broken_warn_formats.NotSpell:format(list_guid, name))
        has_warned_broken[name] = true
        return nil
    end

    local spell_level = spell.Level
    if type(spell_level) ~= "number" then
        Ext.Utils.PrintWarning(broken_warn_formats.InvalidSpellLevel:format(name))
        has_warned_broken[name] = true
        return nil
    end

    if #Trim(spell.SpellContainerID) ~= 0 then
        local container = get_spell_skip_pcalls(spell.SpellContainerID, list_guid)
        if container then
            for contained_spellname in StringSplit(container.ContainerSpells, ";", true) do
                if contained_spellname == name then
                    is_contained_by_container_granting_it[name] = true
                    return nil
                end
            end
        end
        return nil
    end

    validated_spells_cache[name] = spell
    return spell

end


local function generate_sort_key_for_spell(spell_name, spell)
    if sortv_cache[spell_name] ~= nil then
        return true
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

local function SortSpellList(config, spell_list, guid)

    local get_spell_func = config.debug and get_spell_with_validation or get_spell_skip_pcalls

    if spell_list_cache[guid] ~= nil then
        if spell_list ~= nil then
            spell_list.Spells = spell_list_cache[guid]
        end
    else
        local checked_names = {}
        local working_list = {}
        if spell_list ~= nil then
            for _, spell_name in pairs(spell_list.Spells) do
                if checked_names[spell_name] == nil then
                    local spell = get_spell_func(spell_name, guid)
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



local function MagicalSecretsProgressions()

    local ret = {}
    local ids = {}
    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if resourceGuid == bard_guid or desc.ParentGuid == bard_guid then
            ids[desc.ProgressionTableUUID] = true
        end
    end

    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        if ids[pd.TableUUID] ~= nil then
            for _, this_select in ipairs(pd["SelectSpells"]) do
                if magical_secrets_select[this_select.SelectorId] ~= nil then
                    table.insert(ret, progguid)
                end
            end
        end
    end

    return ret
end

local function subtract_setlists(l1, l2)
    -- creates a new list from unique values of l1
    -- that are neither a key or value of l2

    local sub_table = {}
    for key, item in pairs(l2) do
        sub_table[item] = true
        sub_table[key] = true
    end

    local ret = {}
    local seen = {}
    for _, item in pairs(l1) do
        if sub_table[item] == nil then
            if seen[item] == nil then
                table.insert(ret, item)
                seen[item] = true
            end
        end
    end

    return ret
end


---@param config AMSEConfig
local function GetAllValidSecrets(config)

    local get_spell_func = config.debug and get_spell_with_validation or get_spell_skip_pcalls

    local all_spells = {
        [0] = {},
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

    local supprted_secrets_classes = {
        ["114e7aee-d1d4-4371-8d90-8a2080592faf"] = "Cleric",
        ["457d0a6e-9da8-4f95-a225-18382f0e94b5"] = "Druid",
        ["ff4d9497-023c-434a-bd14-82fc367e991c"] = "Paladain",
        ["36be18ba-23db-4dff-bfa6-ae105ce43144"] = "Ranger",
        ["784001e2-c96d-4153-beb6-2adbef5abc92"] = "Sorcerer",
        ["b4225a4b-4bbe-4d97-9e3c-4719dbd1487c"] = "Warlock",
        ["a865965f-501b-46e9-9eaa-7748e8c04d09"] = "Wizard",
        ["92cd50b6-eb1b-4824-8adb-853e90c34c90"] = "Bard",
    }
    local warlock_guid = "b4225a4b-4bbe-4d97-9e3c-4719dbd1487c"

    local collected_spell_lists = {}
    local spell_list_to_class = {}
    local collected_prog_ids = {}
    local prog_to_classname = {}
    local collected_spells = {}
    local collected_warlock_progs = {}
    local warlock_spell_table_assoc = {}

    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        local class_name = supprted_secrets_classes[resourceGuid]
        if class_name ~= nil then
            if desc.SpellList ~= nil then
                collected_spell_lists[desc.SpellList] = true
                local list_class_assoc = spell_list_to_class[desc.SpellList] or {}
                list_class_assoc[class_name] = true
                spell_list_to_class[desc.SpellList] = list_class_assoc
            end
            collected_prog_ids[desc.ProgressionTableUUID] = true
            prog_to_classname[desc.ProgressionTableUUID] = class_name
        end
        if desc.ParentGuid == warlock_guid then
            collected_warlock_progs[desc.ProgressionTableUUID] = true
        end
    end

    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        if collected_prog_ids[pd.TableUUID] ~= nil then
            for _, this_select in ipairs(pd["SelectSpells"]) do
                collected_spell_lists[this_select.SpellUUID] = true
                local list_class_assoc = spell_list_to_class[this_select.SpellUUID] or {}
                list_class_assoc[prog_to_classname[pd.TableUUID]] = true
                spell_list_to_class[this_select.SpellUUID] = list_class_assoc
            end
        end
        if collected_warlock_progs[pd.TableUUID] ~= nil then
            for _, this_select in ipairs(pd["SelectSpells"]) do
                local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                if spell_list ~= nil then
                    for _, spell_name in pairs(spell_list.Spells) do
                        if get_spell_func(spell_name, this_select.SpellUUID) then
                            local assoc = warlock_spell_table_assoc[spell_name] or {}
                            assoc[pd.TableUUID] = true
                            warlock_spell_table_assoc[spell_name] = assoc
                        end
                    end
                end
            end
        end
    end

    for spell_name, guids in pairs(warlock_spell_table_assoc) do
        if #guids >= 3 then
            collected_spells[spell_name] = true
        end
    end

    for list_uuid, _ in pairs(collected_spell_lists) do
        local spell_list = Ext.StaticData.Get(list_uuid, "SpellList")
        if spell_list ~= nil then
            for _, spell_name in pairs(spell_list.Spells) do
                if get_spell_func(spell_name, list_uuid) then
                    collected_spells[spell_name] = true
                end
            end
        end
    end

    for spell_name, _ in pairs(collected_spells) do
        local spell = get_spell_func(spell_name, "IGNORE")
        if spell ~= nil then
            all_spells[spell.Level][spell_name] = true
        end
    end

    return all_spells

end

function ModifyLists()
    local config = LoadConfig()
    local has_secrets = MagicalSecretsProgressions()
    local all_secret_spells = GetAllValidSecrets(config)
    local to_subtract = never_include_as_secrets
    local seen_spells = {}

    local get_spell_func = config.debug and get_spell_with_validation or get_spell_skip_pcalls

    for _, progguid in ipairs(has_secrets) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        local secret_spell_level = (pd.Level > 17) and 9 or ((pd.Level + 1) // 2)

        for _, this_select in ipairs(pd["SelectSpells"]) do
            if magical_secrets_select[this_select.SelectorId] ~= nil then
                local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                if spell_list ~= nil then

                    local working_list = {}

                    for _, spell in pairs(spell_list.Spells) do
                        if seen_spells[spell] == nil then
                            local spell_data = get_spell_func(spell, this_select.SpellUUID)
                            if spell_data ~= nil then
                                table.insert(working_list, spell)
                            end

                        end

                    for lv, spells in pairs(all_secret_spells) do
                        if lv <= secret_spell_level then
                            for spell, _ in pairs(spells) do
                                table.insert(working_list, spell)
                            end
                        end
                    end

                    working_list = subtract_setlists(working_list, seen_spells)
                    spell_list.Spells = subtract_setlists(working_list, to_subtract)
                    SortSpellList(config, spell_list, this_select.SpellUUID)
                    end
                end
            end
        end
    end
end
