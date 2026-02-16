Ext.Require("Utils.lua")

local bard_guid = "92cd50b6-eb1b-4824-8adb-853e90c34c90"


local magical_secrets_select = {["BardMagicalSecrets"] = true}

-- Matches the removal done by
-- "Use 5e spells with Mystra's Spells" Mod.
-- See article: https://www.nexusmods.com/baldursgate3/articles/1536
-- only used when this mod is present, otherwise we assume the user
-- wants duplicates as options or is handling it themselves.
local known_5e_with_mystras_duplicates = {
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

local never_include_as_secrets = {
    ["Target_Daylight"] = true,
    ["Target_EnsnaringStrike"] = true,
    ["Shout_Shield_Sorcerer"] = true,
    ["Shout_Shield_Warlock"] = true,
    ["Shout_ShadowBlade_Spell"] = true,
}


local sortv_cache = {}
local validated_spells_cache = {}
local has_warned_broken = {}
local has_warned_broken_list = {
    ["IGNORE"] = true
}

local broken_warn_formats = {
    NotSpell = "[AutomaticMagicalSecretsExtender] [Source class: %s] Spell list %s contained something other than a spell. The bad entry is named %s",
    InvalidSpellLevel = "[AutomaticMagicalSecretsExtender] The spell named %s has an invalid level",
    InvalidSpellContainerID = "[AutomaticMagicalSecretsExtender] The spell named %s has an invalid container ID specified",
    MissingSpell = "[AutomaticMagicalSecretsExtender] [Source class: %s] Spell list %s contained a spell that isn't defined named %s",
    InvalidSpellName = "[AutomaticMagicalSecretsExtender] [Source class: %s] Spell list: %s contains an invalid spell name",
}

local function generate_sort_key_for_spell(spell_name, spell)
    if sortv_cache[spell_name] ~= nil then
        return true
    end

    local translated_name = Ext.Loca.GetTranslatedString(spell.DisplayName)
    local sort_name = (translated_name or "") .. spell_name

    sortv_cache[spell_name] = {["Level"] = spell.Level, ["Name"] = sort_name}
    return true
end

---@param name string
---@param list_guid string
---@param classnames string
local function get_spell_with_validation(name, list_guid, classnames, debug)
    --- Gets spell data if it exists, that the attributes we need to be valid are valid,
    --- and the spell data does not indicate that the spell is the interior of a container
    --- logs warnings once per spell with broken attributes

    local maybe_spell = validated_spells_cache[name]
    if maybe_spell then
        return maybe_spell
    end

    if type(name) ~= "string" or #name < 1 then
        local list_key = list_guid .. classnames
        if debug and has_warned_broken_list[list_key] == nil then
            Ext.Utils.PrintWarning(broken_warn_formats.InvalidSpellName:format(classnames, list_guid))
            has_warned_broken_list[list_key] = true
        end
        return nil
    end

    if has_warned_broken[name] ~= nil then
        return nil
    end

    local spell = Ext.Stats.Get(name)
    if spell == nil then
        Ext.Utils.PrintWarning(broken_warn_formats.MissingSpell:format(classnames, list_guid, name))
        has_warned_broken[name] = true
        return nil
    end

    local ok, result

    ok, result = pcall(function() return spell.ModifierList end)

    if not ok or type(result) ~= "string" or result ~= "SpellData" then
        Ext.Utils.PrintWarning(broken_warn_formats.NotSpell:format(classnames, list_guid, name))
        has_warned_broken[name] = true
        return nil
    end

    ok, result = pcall(function() return spell.SpellContainerID end)
    if not ok or type(result) ~= "string" then
        Ext.Utils.PrintWarning(broken_warn_formats.InvalidSpellContainerID:format(name))
        has_warned_broken[name] = true
        return nil
    end

    ok, result = pcall(function() return spell.Level end)
    if not ok or type(result) ~= "number" then
        Ext.Utils.PrintWarning(broken_warn_formats.InvalidSpellLevel:format(name))
        has_warned_broken[name] = true
        return nil
    end

    if #spell.SpellContainerID:match("^%s*(.-)%s*$") ~= 0 then
        return nil
    end

    validated_spells_cache[name] = spell
    generate_sort_key_for_spell(name, spell)
    return spell

end


local function sort_func(a, b)

    local lhs = sortv_cache[a]
    local rhs = sortv_cache[b]

    if lhs.Level ~= rhs.Level then
        return lhs.Level > rhs.Level
    end
    return lhs.Name < rhs.Name
end


local function CrawlProgressionData()

    local bard_prog_table_ids = {}
    local bard_secrets_progression_ids = {}

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

    for resourceGuid, desc in StaticDataIterator("ClassDescription") do

        if resourceGuid == bard_guid or desc.ParentGuid == bard_guid then
            bard_prog_table_ids[desc.ProgressionTableUUID] = true
        end

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

    for progguid, pd in StaticDataIterator("Progression") do

        if bard_prog_table_ids[pd.TableUUID] ~= nil then
            for this_select in ListIter(pd["SelectSpells"]) do
                if magical_secrets_select[this_select.SelectorId] ~= nil then
                    table.insert(bard_secrets_progression_ids, progguid)
                end
            end
        end

        if collected_prog_ids[pd.TableUUID] ~= nil then
            for this_select in ListIter(pd["SelectSpells"]) do
                collected_spell_lists[this_select.SpellUUID] = true
                local list_class_assoc = spell_list_to_class[this_select.SpellUUID] or {}
                list_class_assoc[prog_to_classname[pd.TableUUID]] = true
                spell_list_to_class[this_select.SpellUUID] = list_class_assoc
            end
        end
        if collected_warlock_progs[pd.TableUUID] ~= nil then
            for this_select in ListIter(pd["SelectSpells"]) do
                local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                if spell_list ~= nil then
                    for spell_name in ListIter(spell_list.Spells) do
                        if get_spell_with_validation(spell_name, this_select.SpellUUID, "Warlock") then
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

    for list_uuid in SetIter(collected_spell_lists) do
        local spell_list = Ext.StaticData.Get(list_uuid, "SpellList")
        if spell_list ~= nil then
            local class_names = {}
            for cl in SetIter(spell_list_to_class[list_uuid]) do
                table.insert(class_names, cl)
            end
            local names = table.concat(class_names, ",")
            for spell_name in ListIter(spell_list.Spells) do
                if get_spell_with_validation(spell_name, list_uuid, names) then
                    collected_spells[spell_name] = true
                end
            end
        end
    end

    for spell_name in SetIter(collected_spells) do
        local spell = get_spell_with_validation(spell_name, "IGNORE", "IGNORE")
        if spell ~= nil then
            all_spells[spell.Level][spell_name] = true
        end
    end

    return bard_secrets_progression_ids, all_spells

end

function ModifyLists()

    local has_secrets, all_secret_spells = CrawlProgressionData()
    local use_mystras_with_5e_loaded = Ext.Mod.IsModLoaded("5d1585fa-973a-5721-8bce-4bfbbc84072a")
    local to_subtract = never_include_as_secrets

    if use_mystras_with_5e_loaded then
        for spell_name, _ in SetIter(known_5e_with_mystras_duplicates) do
            to_subtract[spell_name] = true
        end
    end

    for progguid in ListIter(has_secrets) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        local secret_spell_level = (pd.Level > 17) and 9 or ((pd.Level + 1) // 2)

        for this_select in ListIter(pd["SelectSpells"]) do
            if magical_secrets_select[this_select.SelectorId] ~= nil then
                local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                if spell_list ~= nil then

                    local co = coroutine.create(
                        function()
                            for spell in ListIter(spell_list.Spells) do
                                local spell_data = get_spell_with_validation(spell, this_select.SpellUUID, "Bard")
                                if spell_data ~= nil then
                                    coroutine.yield(spell)
                                end
                            end

                            for lv, spells in pairs(all_secret_spells) do
                                if lv <= secret_spell_level then
                                    for spell in SetIter(spells) do
                                        coroutine.yield(spell)
                                    end
                                end
                            end

                        end
                    )
                    local it = function()
                        local _, value = coroutine.resume(co)
                        return value
                    end

                    local sorted = {}
                    for spell in Unique(it, to_subtract) do
                        BinInsert(sorted, spell, sort_func)
                    end
                    spell_list.Spells = sorted
                end
            end
        end
    end
end
