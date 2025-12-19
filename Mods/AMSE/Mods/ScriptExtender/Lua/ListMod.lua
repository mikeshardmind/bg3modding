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


function GetProgressionData()
    local desc = Ext.StaticData.Get(bard_guid, "ClassDescription")
    local data = {}

    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        if pd.TableUUID == desc.ProgressionTableUUID then
            table.insert(data, {["Lv"] = pd.Level, ["uu"] = progguid, ["prog"] = pd})
        end
    end

    table.sort(data, function(a, b) return a.Lv < b.Lv end)
    return data
end


function AlwaysMagicalSecrets()

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


function GetAllValidSecrets()

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
        ["114e7aee-d1d4-4371-8d90-8a2080592faf"] = true, --cleric
        ["457d0a6e-9da8-4f95-a225-18382f0e94b5"] = true, -- druid
        ["ff4d9497-023c-434a-bd14-82fc367e991c"] = true, --paladain
        ["36be18ba-23db-4dff-bfa6-ae105ce43144"] = true, -- ranger
        ["784001e2-c96d-4153-beb6-2adbef5abc92"] = true, -- sorc
        ["b4225a4b-4bbe-4d97-9e3c-4719dbd1487c"] = true, -- lock
        ["a865965f-501b-46e9-9eaa-7748e8c04d09"] = true, -- wiz
    }
    local warlock_guid = "b4225a4b-4bbe-4d97-9e3c-4719dbd1487c"

    local collected_spell_lists = {}
    local collected_prog_ids = {}
    local collected_spells = {}
    local collected_warlock_progs = {}
    local warlock_spell_table_assoc = {}

    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if supprted_secrets_classes[resourceGuid] ~= nil then
            if desc.SpellList ~= nil then
                collected_spell_lists[desc.SpellList] = true
            end
            collected_prog_ids[desc.ProgressionTableUUID] = true
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
            end
        end
        if collected_warlock_progs[pd.TableUUID] ~= nil then
            for _, this_select in ipairs(pd["SelectSpells"]) do
                local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                if spell_list ~= nil then
                    for _, spell in pairs(spell_list.Spells) do
                        local assoc = warlock_spell_table_assoc[spell] or {}
                        assoc[pd.TableUUID] = true
                        warlock_spell_table_assoc[spell] = assoc
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
            for _, spell in pairs(spell_list.Spells) do
                collected_spells[spell] = true
            end
        end
    end

    for spell_name, _ in pairs(collected_spells) do
        local spell = Ext.Stats.Get(spell_name)
        if spell ~= nil then
            if #spell.SpellContainerID:match("^%s*(.-)%s*$") == 0 then
                all_spells[spell.Level][spell_name] = true
            end
        end
    end

    return all_spells

end

function ModifyLists()

    SetPrepared()

    local has_secrets = AlwaysMagicalSecrets()
    local all_secret_spells = GetAllValidSecrets()
    local use_mystras_with_5e_loaded = Ext.Mod.IsModLoaded("5d1585fa-973a-5721-8bce-4bfbbc84072a")
    local to_subtract = never_include_as_secrets

    if use_mystras_with_5e_loaded then
        for spell_name, _ in pairs(known_5e_with_mystras_duplicates) do
            to_subtract[spell_name] = true
        end
    end

    local seen_lists = {}
    local seen_spells = {}

    local prog_data = GetProgressionData()
    local our_lists = GetOurLists()


    for _, data in ipairs(prog_data) do

        local lv = data.Lv
        local spell_lv = (lv > 17) and 9 or ((lv + 1) // 2)
        local our_acc = our_lists[spell_lv].acc

        local to_remove = {}

        for idx, this_select in ipairs(data.prog["SelectSpells"]) do
            if magical_secrets_select[this_select.SelectorId] == nil then
                table.insert(to_remove, idx)

                if seen_lists[this_select.SpellUUID] == nil then
                    local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                    if spell_list ~= nil then
                        for _, spell in pairs(spell_list.Spells) do

                            if seen_spells[spell] == nil then
                                table.insert(our_acc, spell)
                            end
                            seen_spells[spell] = true

                        end
                    end

                end
                seen_lists[this_select.SpellUUID] = true

            end

        end

    end

    for _, progguid in ipairs(has_secrets) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        local secret_spell_level = (pd.Level > 17) and 9 or ((pd.Level + 1) // 2)

        for _, this_select in ipairs(pd["SelectSpells"]) do
            if magical_secrets_select[this_select.SelectorId]  ~= nil then
                local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                if spell_list ~= nil then

                    local working_list = {}

                    for _, spell in pairs(spell_list.Spells) do
                        if seen_spells[spell] == nil then
                            local spell_data = Ext.Stats.Get(spell)
                            if spell_data ~= nil then
                                if #spell_data.SpellContainerID:match("^%s*(.-)%s*$") == 0 then
                                    table.insert(working_list, spell)
                                end
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
                    end
                end
            end
        end
    end
end
