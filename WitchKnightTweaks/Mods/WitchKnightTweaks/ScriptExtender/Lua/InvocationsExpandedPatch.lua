bow_pattern = "IF\\(ClassLevelHigherOrEqualThan\\((\\d+),'Warlock'\\) and not ClassLevelHigherOrEqualThan\\((\\d+),'Warlock'\\)\\):([^;]*);"
bow_substitution = "$&;IF((HasPassive('LHB_SanguineOffering_Unlock') or HasPassive('LHB_GreaterSanguineOffering_Unlock')) and ClassLevelHigherOrEqualThan($2,'Fighter') and not ClassLevelHigherOrEqualThan($1,'Fighter')) and not ClassLevelHigherOrEqualThan($2,'Fighter') and not ClassLevelHigherOrEqualThan(1,'Warlock'):$3;"

--[[
  So, lua doesn't have regex....
  May use https://gitlab.com/demurgos/hre/-/tree/master
  Haxe's ability to generate good lua code: https://haxe.org/manual/target-lua-getting-started.html
  I'm aware of gsub, but I really don't want to trust all spellprops from all mods people may
  load are well formed.
]]--

bows = {
  "Shout_PactOfTheBlade_HeavyCrossbow",
  "Shout_PactOfTheBlade_LightCrossbow",
  "Shout_PactOfTheBlade_HandCrossbow",
  "Shout_PactOfTheBlade_Longbow"
}


if Ext.Mod.IsModLoaded("67fbbd53-7c7d-4cfa-9409-6d737b4d92a9") then

  local function OnStatsLoaded()

    for _, s in ipairs(bows) do

      local spell = Ext.Stats.Get(s)
      if spell ~= nil then

        local properties = spell.SpellProperties

        for _, spellprop in ipars(properties) do

          local spellfunctors = spellprop.Functors

          if spellfunctors ~= nil then

            for _, func in ipairs(spellfunctors) do
              local conds = func.StatsConditions
              if conds ~= nil then

              end
            end

          end
        end

        spell.SpellProperties = properties

      end
    end
  end

  Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)
end