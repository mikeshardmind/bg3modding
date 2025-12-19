Ext.Require("ListSort.lua")

local function on_swap_level(event)
	if event.FromState == "LoadSession" and event.ToState == "LoadLevel" then
		ModifyLists()
	end
end

Ext.Events.GameStateChanged:Subscribe(on_swap_level, {Priority = -300})
Ext.Events.ResetCompleted:Subscribe(ModifyLists, {Priority = -300})