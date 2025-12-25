Ext.Require("ModLib.lua")

local sorc_guid = "784001e2-c96d-4153-beb6-2adbef5abc92"
local filename = "SorcerousPreparation.json"
local spell_action_resource = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"

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

function ModifyLists()
    API_ModifyLists(sorc_guid, spell_action_resource, filename, Ours, OursRitual)
end