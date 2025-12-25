Ext.Require("ModLib.lua")

local ranger_guid = "36be18ba-23db-4dff-bfa6-ae105ce43144"
local filename = "RangersPreparation.json"
local spell_action_resource = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"

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

function ModifyLists()
    API_ModifyLists(ranger_guid, spell_action_resource, filename, Ours, OursRitual)
end