Ext.Require("ModLib.lua")

local warlock_guid = "b4225a4b-4bbe-4d97-9e3c-4719dbd1487c"
local filename = "EldritchPreparation.json"
local spell_action_resource = "e9127b70-22b7-42a1-b172-d02f828f260a"


function ModifyLists()
    API_ModifyLists(warlock_guid, spell_action_resource, filename)
end