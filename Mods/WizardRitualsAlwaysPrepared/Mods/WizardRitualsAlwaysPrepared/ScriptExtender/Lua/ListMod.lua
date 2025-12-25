Ext.Require("ModLib.lua")

local wizard_guid = "a865965f-501b-46e9-9eaa-7748e8c04d09"

local OursRitual = {
    "aa6ed3b3-c435-4516-906e-305c08d0fd59",
    "decf9006-d9c0-4367-ae82-06b1ea4d078b",
    "b9290623-59b0-42ea-9282-f558afe271ac",
    "064d3a11-9a22-4cdc-a144-14e0c021eaf0",
    "4fe7fcb3-6130-4e19-9a57-aec2061eeadc",
    "e3becc0a-1ee6-4eeb-a5cb-f53001ae92b4",
    "74ca601b-2269-444d-bc6c-023dd9780ed0",
    "d74612e2-d3db-41ca-8341-0f6da0f4935b",
    "70b128bc-ff15-450c-999c-61e751cc3443",
}

function ModifyLists()
    API_WizModifyLists(wizard_guid, OursRitual)
end
