local sorc_guid = "784001e2-c96d-4153-beb6-2adbef5abc92"

local Selector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = sorc_guid,
    ["CooldownType"] = "Default",
    ["PrepareType"] = "Unknown",
    ["SpellUUID"] = "",
    ["SelectorId"] = " "
}

local RitualSelector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = sorc_guid,
    ["CooldownType"] = "Default",
    ["PrepareType"] = "AlwaysPrepared",
    ["SpellUUID"] = "",
    ["SelectorId"] = " "
}


local Ours = {
    "1b3954dd-d174-48a4-af90-92850353c40d",
    "4b5566a2-6e58-428e-9437-358b325be5b2",
    "8bb068be-ad2c-43af-b05b-3c852b8e27ed",
    "d559ed43-971b-4ada-a275-1e24da88e8a4",
    "bab76edf-0a72-40e3-ade6-05cb730de263",
    "0c892882-b50c-4ff8-acf0-c744ef17583f",
    "0fbb80cb-8627-4c66-82f6-35fef5c33302",
    "d4a21c92-200c-4c4a-8718-cc5187174fc3",
    "149e22ee-bf11-4573-bcac-17dbfc086600",
}

local OursRitual = {
    "6deeb481-a642-4fd3-bea0-206e22061269",
    "81fe9040-49ce-4533-a146-aba430c61be0",
    "e6764b87-46c0-44ac-b3ff-380689da4f76",
    "1b7fbc1d-c2a6-4cde-aa33-8eaa55b02b5f",
    "58597bf1-c5c8-45a9-adbd-4ad2e87b5972",
    "616adde7-0300-4b3b-a750-a47947e68cf7",
    "0729421c-2175-4997-bf54-4b5d6bf2902d",
    "ed772d36-7ac1-4ac8-9ddd-3922bcf86b7e",
    "60be2839-8474-484d-a5c8-be5eed598472",
}


local defaultConfig = {
    enabled = true,
    with_scroll_learning = false,
    rituals_always_prepared = true,
}


local function LoadConfigFile()
    local file = Ext.IO.LoadFile("SorcerousPreparation.json")
    if file == nil then
        local d = Ext.Json.Stringify(defaultConfig)
        Ext.IO.SaveFile("SorcerousPreparation.json", d)
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
    Ext.IO.SaveFile("SorcerousPreparation.json", d)
    -- https://www.nexusmods.com/baldursgate3/mods/6770
    -- Xara's Remove Spell Preparation Mod.
    -- We get run after that mod, lets respect user choices here.
    ret.disable_prep_requirement = Ext.Mod.IsModLoaded("0e8d791a-8338-4aeb-adf0-cd5e68151107")
    return ret

end


local function ModifyDescriptionsAndCollectProgressions(config)
    local ret = {}

    local class_prog_table_ids = {}

    local subclass_prog_table_ids = {}
    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if desc.ParentGuid == sorc_guid then
            subclass_prog_table_ids[desc.ProgressionTableUUID] = true
            desc.CanLearnSpells = config.with_scroll_learning
        end
        if resourceGuid == sorc_guid then
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


function OnStatsLoaded()

    local config = LoadConfig()
    if config.enabled ~= true then
        return
    end

    local use_mystras_with_5e_loaded = Ext.Mod.IsModLoaded("5d1585fa-973a-5721-8bce-4bfbbc84072a")

    local to_subtract = use_mystras_with_5e_loaded and known_5e_mystras_duplicates or {}

    local seen_lists = {}
    local seen_sorc_spells = {}

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
                            table.insert(seen_sorc_spells, spell)
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

    local sorc_desc = Ext.StaticData.Get(sorc_guid, "ClassDescription")
    local sorc_list = Ext.StaticData.Get(sorc_desc.SpellList, "SpellList")

    sorc_list.Spells = subtract_setlists(seen_sorc_spells, to_subtract)

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

    for _, spellname in ipairs(seen_sorc_spells) do
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

-- We want to be after compatability framework
Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded, {Priority = -100})
