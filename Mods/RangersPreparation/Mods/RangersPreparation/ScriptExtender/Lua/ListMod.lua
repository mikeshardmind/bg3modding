local ranger_guid = "36be18ba-23db-4dff-bfa6-ae105ce43144"

local Selector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = ranger_guid,
    ["CooldownType"] = "Default",
    ["PrepareType"] = "Unknown",
    ["SpellUUID"] = "",
    ["SelectorId"] = " "
}

local RitualSelector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = ranger_guid,
    ["CooldownType"] = "Default",
    ["PrepareType"] = "AlwaysPrepared",
    ["SpellUUID"] = "",
    ["SelectorId"] = " "
}


local Ours = {
    "db36af8d-7e7a-48b7-8aea-a59816f52906",
    "dcb7329c-6d22-4e5a-9953-0a58d685846d",
    "22327755-48b6-45b8-859a-ac32a1205441",
    "dabe1b69-f350-43af-abb5-6947cf01adb0",
    "2fc702ca-e35b-4e14-b117-0d64467d57ec",
    "7ca85ca7-cdcd-4320-b845-5e42cff697a9",
    "7751eec2-0b00-407b-938e-be008ea506f7",
    "45839e9f-b16c-432d-8d9c-698c7209bed2",
    "fcd092ad-3956-41e6-8b08-d590488fcfdb",
}

local OursRitual = {
    "a0a0b3e4-5334-419c-ade9-c8a2614d1e8c",
    "4432095a-200a-40b9-adbc-1ab349d00d42",
    "af8ec2ef-8484-4c55-b8bc-bf09b8bb97e3",
    "2d61ebeb-f0ea-4afe-bd8d-72803a8c3508",
    "69ad6738-04ae-4661-8e10-7a1e495bba76",
    "8727ae7d-3c42-4f59-9f90-4c5366538bc9",
    "5f2778af-f8d7-4abb-9b99-33d031568153",
    "75926093-14b4-422b-ad1c-32d91221c6e2",
    "c2846841-1430-4879-aba6-e83f31021a26",
}

local HalfCasterFirstLearned = {
    [2] = 1,
    [5] = 2,
    [9] = 3,
    [13] = 4,
    [17] = 5,
}

local function max_known_spell(config, level)
    local spell_lv = 0

    if config.using_fullcaster_conversion then
        return (level > 17) and 9 or ((level + 1) // 2)
    end

    for lv, slv in pairs(HalfCasterFirstLearned) do
        if level >= lv and slv >= spell_lv then spell_lv = slv end
    end
    return spell_lv
end


local defaultConfig = {
    enabled = true,
    with_scroll_learning = false,
    rituals_always_prepared = true,
}


local function LoadConfigFile()
    local file = Ext.IO.LoadFile("RangersPreparation.json")
    if file == nil then
        local d = Ext.Json.Stringify(defaultConfig)
        Ext.IO.SaveFile("RangersPreparation.json", d)
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
    Ext.IO.SaveFile("RangersPreparation.json", d)
    -- https://www.nexusmods.com/baldursgate3/mods/6770
    -- Xara's Remove Spell Preparation Mod.
    -- We get run after that mod, lets respect user choices here.
    ret.disable_prep_requirement = Ext.Mod.IsModLoaded("0e8d791a-8338-4aeb-adf0-cd5e68151107")
    -- Below aren't exposed to users yet.
    ret.using_fullcaster_conversion = false
    return ret

end


local function ModifyDescriptionsAndCollectProgressions(config)
    local ret = {}

    local class_prog_table_ids = {}

    local subclass_prog_table_ids = {}
    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if desc.ParentGuid == ranger_guid then
            subclass_prog_table_ids[desc.ProgressionTableUUID] = true
            desc.CanLearnSpells = config.with_scroll_learning
        end
        if resourceGuid == ranger_guid then
            class_prog_table_ids[desc.ProgressionTableUUID] = true
            desc.MustPrepareSpells = not config.disable_prep_requirement
            desc.CanLearnSpells = config.with_scroll_learning
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


function ModifyLists()

    local config = LoadConfig()
    if config.enabled ~= true then
        return
    end

    local use_mystras_with_5e_loaded = Ext.Mod.IsModLoaded("5d1585fa-973a-5721-8bce-4bfbbc84072a")

    local to_subtract = use_mystras_with_5e_loaded and known_5e_mystras_duplicates or {}

    local seen_lists = {}
    local seen_ranger_spells = {}

    local prog_data = ModifyDescriptionsAndCollectProgressions(config)

    for _, data in ipairs(prog_data) do
        local pd = data.prog
        local lv = data.Lv
        local spell_lv = max_known_spell(config, lv)

        local to_remove = {}
        for idx, this_select in ipairs(data.prog["SelectSpells"]) do

            if this_select.PrepareType == "Unknown" then
                table.insert(to_remove, idx)
                if seen_lists[this_select.SpellUUID] == nil then
                    local spell_list = Ext.StaticData.Get(this_select.SpellUUID, "SpellList")
                    if spell_list ~= nil then
                        for _, spell in pairs(spell_list.Spells) do
                            table.insert(seen_ranger_spells, spell)
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

        if config.using_fullcaster_conversion then
            if (lv < 18) and (lv % 2 == 1) then
                Selector.SpellUUID = Ours[spell_lv]
                RitualSelector.SpellUUID = OursRitual[spell_lv]
                pd["AddSpells"][#pd["AddSpells"] + 1] = Selector
                pd["AddSpells"][#pd["AddSpells"] + 1] = RitualSelector
            end
        else
            if HalfCasterFirstLearned[lv] ~= nil then
                Selector.SpellUUID = Ours[spell_lv]
                RitualSelector.SpellUUID = OursRitual[spell_lv]
                pd["AddSpells"][#pd["AddSpells"] + 1] = Selector
                pd["AddSpells"][#pd["AddSpells"] + 1] = RitualSelector
            end
        end

    end

    local ranger_desc = Ext.StaticData.Get(ranger_guid, "ClassDescription")
    local ranger_list = Ext.StaticData.Get(ranger_desc.SpellList, "SpellList")
    local total_list = subtract_setlists(seen_ranger_spells, to_subtract)

    ranger_list.Spells = total_list

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

    for _, spellname in ipairs(seen_ranger_spells) do
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
