Ext.Require("AMSE_compat.lua")

local function on_swap_level(event)
	if event.FromState == "LoadSession" and event.ToState == "LoadLevel" then
		RemoveBardSpellsFromBardSecrets()
	end
end

Ext.Events.GameStateChanged:Subscribe(on_swap_level, {Priority = -600})
Ext.Events.ResetCompleted:Subscribe(RemoveBardSpellsFromBardSecrets(), {Priority = -600})