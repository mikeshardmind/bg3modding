local warlock_guid = "b4225a4b-4bbe-4d97-9e3c-4719dbd1487c"

local Selector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = warlock_guid,
    ["CooldownType"] = "Default",
    ["PrepareType"] = "Unknown",
    ["SpellUUID"] = "",
    ["SelectorId"] = " "
}

local RitualSelector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = warlock_guid,
    ["CooldownType"] = "Default",
    ["PrepareType"] = "AlwaysPrepared",
    ["SpellUUID"] = "",
    ["SelectorId"] = " "
}


local Ours = {
    "c6b91154-7e0a-4552-a82a-a6f52d06d4b7",
    "ab570f43-a22a-450a-9f6d-b4eb1b442cb4",
    "59e39d99-9148-42e6-915d-c6d255c04047",
    "cd51c573-23e9-48c9-bbbd-36c5d6a5e976",
    "c8152031-2e88-4e9b-b5eb-b9458e5ab5be",
    "ffabad14-e6b8-408d-9a62-5d108c5f3924",
    "a8418f5b-e053-422c-bf4f-1e3c1fa29d48",
    "3670b2c2-d3e2-420e-8042-f3f98234ab1d",
    "df592fcb-1dfe-46c0-8371-d525ce85839c",
}

local OursRitual = {
    "dba24213-210e-4610-ae27-5861fb2ff4fe",
    "09bfbcbf-6602-4bee-8c6b-78d3dccc3bc9",
    "1b79be47-a25a-4621-a26d-f159b75d67c0",
    "41848065-a834-4ae3-8ee8-583c5db49937",
    "18bb99c2-e6fc-4b55-91cc-7016a6c1bb3c",
    "85b88a43-8c18-4f69-bdce-af0119c000c7",
    "44fc309a-5d49-4387-84fb-c17f10afe738",
    "38ec742f-c856-4662-a30c-58b9b4e0a2e5",
    "cc2e64dd-e13b-45e4-8318-d80e561cbe38",
}


local defaultConfig = {
    enabled = true,
    with_scroll_learning = false,
    rituals_always_prepared = true,
}


local function LoadConfigFile()
    local file = Ext.IO.LoadFile("EldritchPreparation.json")
    if file == nil then
        local d = Ext.Json.Stringify(defaultConfig)
        Ext.IO.SaveFile("EldritchPreparation.json", d)
        return Ext.Json.Parse(d)
    end
    return Ext.Json.Parse(file) or {}

end

local function LoadConfig()

    local ret = LoadConfigFile()
    ret.enabled = (ret.enabled ~= false)
    ret.with_scroll_learning = (ret.with_scroll_learning ~= false)
    ret.rituals_always_prepared = (ret.rituals_always_prepared ~= false)
    local d = Ext.Json.Stringify(ret)
    Ext.IO.SaveFile("EldritchPreparation.json", d)
    return ret

end


local function ModifyDescriptionsAndCollectProgressions(config)
    local with_scroll_learning = config.with_scroll_learning
    local ret = {}

    local class_prog_table_ids = {}

    local subclass_prog_table_ids = {}
    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if desc.ParentGuid == warlock_guid then
            subclass_prog_table_ids[desc.ProgressionTableUUID] = true
            desc.CanLearnSpells = with_scroll_learning
        end
        if resourceGuid == warlock_guid then
            class_prog_table_ids[desc.ProgressionTableUUID] = true
            desc.MustPrepareSpells = true
            desc.CanLearnSpells = with_scroll_learning
        end
    end

    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        if subclass_prog_table_ids[pd.TableUUID] ~= nil then
            for _, this_select in ipairs(pd["SelectSpells"]) do
                this_select.PrepareType = "AlwaysPrepared"
            end
            for _, this_select in ipairs(pd["AddSpells"]) do
                this_select.PrepareType = "AlwaysPrepared"
            end
        end

        if class_prog_table_ids[pd.TableUUID] ~= nil then
            table.insert(ret, {["Lv"] = pd.Level, ["uu"] = progguid, ["prog"] = pd})
            for _, this_select in ipairs(pd["AddSpells"]) do
                this_select.PrepareType = "AlwaysPrepared"
            end
        end
    end

    table.sort(ret, function(a, b) return a.Lv < b.Lv end)
    return ret
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


function OnStatsLoaded()

    local config = LoadConfig()
    if config.enabled ~= true then
        return
    end

    local use_mystras_with_5e_loaded = Ext.Mod.IsModLoaded("5d1585fa-973a-5721-8bce-4bfbbc84072a")

    local to_subtract = use_mystras_with_5e_loaded and known_5e_mystras_duplicates or {}

    local seen_lists = {}
    local seen_warlock_spells = {}

    local prog_data = ModifyDescriptionsAndCollectProgressions(config)

    for _, data in ipairs(prog_data) do
        local pd = data.prog
        local lv = data.Lv
        local spell_lv = (lv > 17) and 9 or ((lv + 1) // 2)

        local to_remove = {}
        for idx, this_select in ipairs(data.prog["SelectSpells"]) do

            if this_select.PrepareType == "Unknown" then
                table.insert(to_remove, idx)
                if seen_lists[this_select.SpellUUID] == nil then
                    local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                    if spell_list ~= nil then
                        for _, spell in pairs(spell_list.Spells) do
                            table.insert(seen_warlock_spells, spell)
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

        if (lv < 18) and (lv % 2 == 1) then
            Selector.SpellUUID = Ours[spell_lv]
            RitualSelector.SpellUUID = OursRitual[spell_lv]
            pd["AddSpells"][#pd["AddSpells"] + 1] = Selector
            pd["AddSpells"][#pd["AddSpells"] + 1] = RitualSelector
        end

    end

    local warlock_desc = Ext.StaticData.Get(warlock_guid, "ClassDescription")
    local warlock_list = Ext.StaticData.Get(warlock_desc.SpellList, "SpellList")

    warlock_list.Spells = subtract_setlists(seen_warlock_spells, to_subtract)

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

    for _, spellname in ipairs(seen_warlock_spells) do
        local spell = Ext.Stats.Get(spellname)
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

Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)
