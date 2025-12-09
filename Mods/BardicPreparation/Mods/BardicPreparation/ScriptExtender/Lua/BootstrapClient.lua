
local bard_guid = "92cd50b6-eb1b-4824-8adb-853e90c34c90"

local Selector = {
    ["Ability"] = "None",
    ["ActionResource"] = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf",
    ["ClassUUID"] = "00000000-0000-0000-0000-000000000000",
    ["CooldownType"] = "Default",
    ["PrepareType"] = "Unknown",
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

function SetPrepared()
    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if resourceGuid == bard_guid or desc.ParentGuid == bard_guid then
            desc.MustPrepareSpells = true
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

function OnStatsLoaded()

    SetPrepared()
    local prog_data = GetProgressionData()
    local seen_lists = {}
    local seen_spells = {}
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
            if this_select.PrepareType == "Unknown" and this_select.SelectorId  ~= "BardMagicalSecrets" then
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

        table.sort(to_remove, function (a, b) return a > b end)
        for _, idx in ipairs(to_remove) do
            pd["SelectSpells"][idx] = nil
        end

        if (lv < 18) and (lv % 2 == 1) then
            Selector.SpellUUID = Ours[spell_lv]
            pd["AddSpells"][#pd["AddSpells"] + 1] = Selector
        end

    end

    for _, data in ipairs(our_lists) do
        data.List.Spells = data.acc
    end

end

-- We want to be after compatability framework
Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded, {Priority = 200})