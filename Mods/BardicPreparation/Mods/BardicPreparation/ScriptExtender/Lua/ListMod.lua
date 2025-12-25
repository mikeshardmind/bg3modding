Ext.Require("ModLib.lua")

local bard_guid = "92cd50b6-eb1b-4824-8adb-853e90c34c90"
local filename = "BardicPreparation.json"
local spell_action_resource = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"

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

function ModifyLists()
    API_ModifyLists(bard_guid, spell_action_resource, filename, Ours, OursRitual)
end
