Ext.Require("ListMod.lua")

local function on_swap_level(event)
	if event.FromState == "LoadSession" and event.ToState == "LoadLevel" then
		ModifyLists()
	end
end

Ext.Events.GameStateChanged:Subscribe(on_swap_level, {Priority = -200})
Ext.Events.ResetCompleted:Subscribe(ModifyLists, {Priority = -200})