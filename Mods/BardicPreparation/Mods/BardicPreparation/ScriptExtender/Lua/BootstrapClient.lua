-- this code can be cleaned up significantly later.
-- it functions as intended, but has a bit of duplicated iteration
-- with the way in which functionality was expanded upon.
local bard_guid = "92cd50b6-eb1b-4824-8adb-853e90c34c90"

local Selector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = bard_guid,
    ["CooldownType"] = "Default",
    ["PrepareType"] = "Unknown",
    ["SpellUUID"] = "",
    ["SelectorId"] = " "
}

local RitualSelector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = bard_guid,
    ["CooldownType"] = "Default",
    ["PrepareType"] = "AlwaysPrepared",
    ["SpellUUID"] = "",
    ["SelectorId"] = " "
}

local Ours = {
    "a5dae82b-4452-438f-a3e3-ff76951dcd01",
    "898fa5d6-4abf-42b1-bbd6-1bec7eb0c282",
    "3325ed36-e499-4284-acc4-772e51f1e64e",
    "854ae3f1-2eb3-4416-aea9-a1852a056919",
    "fa3ab275-4968-44f5-b252-b0b9128446aa",
    "2e159f46-7354-48e1-9f61-7b6c1b29ee72",
    "97178150-8c85-4381-9a05-2f85d2c60230",
    "d5368041-c4c4-4fbf-9f46-1b662b5529ec",
    "e3d2a506-7aa6-4554-ab2b-ac7a66e1dfbe",
}

local OursRitual = {
    "4980f02c-bb60-4e2f-9bab-e4ce32384b7f",
    "88d8e1cd-b0ff-4d1b-95ff-c816f49d10bf",
    "7eaeeffb-df1f-4276-992a-6e35180a09a5",
    "9785e2c9-f892-429e-ae1d-f74f3abfce6f",
    "e9fefd63-f66e-424c-8187-68d6ef658ddb",
    "1d135e50-82e7-4006-8b61-c226c4c2645b",
    "95b4f5ed-5b1c-477e-94f8-4f47a56cf599",
    "27c9134f-d0b3-410f-80d4-999465397c6e",
    "f9335bad-5549-4976-b6a4-f6ff27426b70"
}

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
    "Target_Daylight",
    "Target_EnsnaringStrike",
    "Shout_Shield_Sorcerer",
    "Shout_Shield_Warlock",
    "Shout_ShadowBlade_Spell",
}

local force_ritual = {
    ["Shout_Glibness"] = true
}

local defaultConfig = {
    enabled = true,
    with_scroll_learning = false,
    rituals_always_prepared = true,
    extend_secrets_lists = true,
    filter_known_from_secrets = true,
    only_bard_secrets = false,
}

local function LoadConfigFile()
    local file = Ext.IO.LoadFile("BardicPreparation.json")
    if file == nil then
        local d = Ext.Json.Stringify(defaultConfig)
        Ext.IO.SaveFile("BardicPreparation.json", d)
        return Ext.Json.Parse(d)
    end
    return Ext.Json.Parse(file) or {}

end


local function LoadConfig()

    local ret = LoadConfigFile()
    ret.enabled = (ret.enabled ~= false)
    ret.with_scroll_learning = (ret.with_scroll_learning ~= false)
    ret.rituals_always_prepared = (ret.rituals_always_prepared ~= false)
    ret.extend_secrets_lists = (ret.extend_secrets_lists ~= false)
    ret.secrets_always_prepared = (ret.secrets_always_prepared ~= false)
    ret.filter_known_from_secrets = (ret.filter_known_from_secrets ~= false)
    ret.only_bard_secrets = (ret.only_bard_secrets ~= false)
    local d = Ext.Json.Stringify(ret)
    Ext.IO.SaveFile("BardicPreparation.json", d)
    -- https://www.nexusmods.com/baldursgate3/mods/6770
    -- Xara's Remove Spell Preparation Mod.
    -- We get run after that mod, lets respect user choices here.
    ret.disable_prep_requirement = Ext.Mod.IsModLoaded("0e8d791a-8338-4aeb-adf0-cd5e68151107")
    -- Below aren't exposed to users yet, maybe ever
    ret.secret_selectors = {["BardMagicalSecrets"] = true}
    return ret

end


function SetPrepared(config)

    if config.only_bard_secrets then
        return
    end

    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if resourceGuid == bard_guid then
            desc.MustPrepareSpells = not config.disable_prep_requirement
            desc.CanLearnSpells = config.with_scroll_learning
        elseif desc.ParentGuid == bard_guid then
            desc.CanLearnSpells = config.with_scroll_learning
        end
    end
end

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

function GetOurLists()
    local t = {}
    for i, v in ipairs(Ours) do
        t[i] = {["List"] = Ext.StaticData.Get(v, "SpellList"), ["acc"] = {}}
    end
    return t
end

function AlwaysMagicalSecrets(config)
    local selectors = config.secret_selectors
    local always_prepared = config.secrets_always_prepared
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
                if selectors[this_select.SelectorId]  ~= nil then
                    if not config.only_bard_secrets then
                        this_select.PrepareType = always_prepared and "AlwaysPrepared" or "Unknown"
                    end
                    table.insert(ret, progguid)
                end
            end
            if not config.only_bard_secrets then
                -- Needed for class actions that are technically spells
                for _, this_select in ipairs(pd["AddSpells"]) do
                    this_select.PrepareType = "AlwaysPrepared"
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


function GetAllValidSecrets(config)

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

function OnStatsLoaded()

    local config = LoadConfig()
    if config.enabled ~= true then
        return
    end

    local secrets_selectors = config.secret_selectors

    SetPrepared(config)

    local has_secrets = AlwaysMagicalSecrets(config)
    local all_secret_spells = config.extend_secrets_lists and GetAllValidSecrets(config) or {}
    local use_mystras_with_5e_loaded = Ext.Mod.IsModLoaded("5d1585fa-973a-5721-8bce-4bfbbc84072a")
    local to_subtract = use_mystras_with_5e_loaded and known_5e_with_mystras_duplicates or {}

    local seen_lists = {}
    local seen_spells = {}

    local bard_spell_desc = Ext.StaticData.Get(bard_guid, "ClassDescription")
    local bard_list = Ext.StaticData.Get(bard_spell_desc.SpellList, "SpellList")

    local prog_data = GetProgressionData()

    local our_lists = GetOurLists()
    -- Below is a large scale dynamic rebuilding of progression data.
    -- If it gives a spell selection, and isn't tagged BardMagicalSecrets
    -- we accumulate it into a newly created list.
    -- This avoids any issues should anything expect the bard list to be level
    -- inclusive.
    -- We need it to only give new spells as to not create duplicates when making
    -- it prepared with full access.
    for _, data in ipairs(prog_data) do

        local pd = data.prog
        local lv = data.Lv
        local spell_lv = (lv > 17) and 9 or ((lv + 1) // 2)
        local our_acc = our_lists[spell_lv].acc

        local to_remove = {}

        for idx, this_select in ipairs(data.prog["SelectSpells"]) do
            if this_select.PrepareType == "Unknown" and secrets_selectors[this_select.SelectorId] == nil then
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

        if not config.only_bard_secrets then
            table.sort(to_remove, function (a, b) return a > b end)
            for _, idx in ipairs(to_remove) do
                pd["SelectSpells"][idx] = nil
            end

            if (lv < 18) and (lv % 2 == 1) then
                Selector.SpellUUID = Ours[spell_lv]
                RitualSelector.SpellUUID = OursRitual[spell_lv]
                pd["AddSpells"][#pd["AddSpells"] + 1] = Selector
                pd["AddSpells"][#pd["AddSpells"] + 1] = RitualSelector
            end
        end
    end

    if not config.only_bard_secrets then
        for i, data in ipairs(our_lists) do

            local prep = {}
            local ritual = {}
            for _, spellname in ipairs(data.acc) do
                local spell = Ext.Stats.Get(spellname)
                if spell ~= nil then
                    if #spell.SpellContainerID:match("^%s*(.-)%s*$") == 0 then
                        if config.rituals_always_prepared and #spell.RitualCosts:match("^%s*(.-)%s*$") > 0 then
                            table.insert(ritual, spellname)
                        elseif force_ritual[spellname] ~= nil then
                            table.insert(ritual, spellname)
                        else
                            table.insert(prep, spellname)
                        end
                    end
                end
            end

            ritual = subtract_setlists(ritual, to_subtract)
            data.List.Spells = subtract_setlists(prep, to_subtract)
            if #ritual > 0 then
                local ritual_list = Ext.StaticData.Get(OursRitual[i], "SpellList")
                ritual_list.Spells = ritual
            end
        end
    end



    for _, progguid in ipairs(has_secrets) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        local secret_spell_level = (pd.Level > 17) and 9 or ((pd.Level + 1) // 2)

        for _, this_select in ipairs(pd["SelectSpells"]) do
            if secrets_selectors[this_select.SelectorId]  ~= nil then
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

                    if config.extend_secrets_lists then
                        for lv, spells in pairs(all_secret_spells) do
                            if lv <= secret_spell_level then
                                for spell, _ in pairs(spells) do
                                    table.insert(working_list, spell)
                                end
                            end
                        end
                    end

                    working_list = subtract_setlists(working_list, never_include_as_secrets)
                    if config.filter_known_from_secrets then
                        working_list = subtract_setlists(working_list, seen_spells)
                    end

                    spell_list.Spells = subtract_setlists(working_list, to_subtract)
                    end
                end
            end
        end
    end

    if not config.only_bard_secrets then
        bard_list.Spells = subtract_setlists(seen_spells, to_subtract)
    end

end

-- We want to be after compatability framework
Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded, {Priority = -100})