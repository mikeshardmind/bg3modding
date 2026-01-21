
local fighting_style_lists = {
    "da3203d8-750a-4de1-b8eb-1eccfccddf46",  --fighter
    "a0bdb113-1cce-45ac-94fb-72d4c3f207e9", -- ranger
    "f8ebba38-932a-4c64-ae55-3df23e2f60fa", -- pally
    "11f3b209-eb13-42d2-9fec-46dfc68fe619", -- swords bard
    "769c453b-ab3d-44d6-894f-169685f8c1e7", -- our baseline
}

local our_list_id = "769c453b-ab3d-44d6-894f-169685f8c1e7"


function ModifyOurList()

    local seen = {}
    local found = {}

    for _, passive_list_uuid in ipairs(fighting_style_lists) do
        local list = Ext.StaticData.Get(passive_list_uuid, "PassiveList").Passives
        for _, name in pairs(list) do
            if seen[name] == nil then
                if Ext.Stats.Get(name) then
                    table.insert(found, name)
                end
            end
            seen[name] = true
        end

    end

    table.sort(found)

    local our_list = Ext.StaticData.Get(our_list_id, "PassiveList")
    our_list.Passives = found

end

Ext.Events.StatsLoaded:Subscribe(ModifyOurList, {Priority = -1})