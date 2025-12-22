Ext.Require("ListMod.lua")

local function on_swap_level(event)
	if event.FromState == "LoadLevel" and event.ToState == "SwapLevel" then
		ModifyLists()
	end
end

Ext.Events.StatsLoaded:Subscribe(ModifyLists, {Priority = -200})
Ext.Events.GameStateChanged:Subscribe(on_swap_level, {Priority = -200})
Ext.Events.ResetCompleted:Subscribe(ModifyLists, {Priority = -200})