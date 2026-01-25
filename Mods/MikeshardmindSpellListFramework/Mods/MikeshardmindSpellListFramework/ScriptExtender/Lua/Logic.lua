Ext.Require("Spells.lua")
Ext.Require("Settings.lua")
Ext.Require("RuleFileParser.lua")
Ext.Require("Utils.lua")


local missing_rule_messages = {
    ["namespace"] = "[SpellListFramework]%s references rule namespace %s not declared in config.",
    ["name"] = "[SpellListFramework]Rule named %s not declared in namespace %s",
}

---@param g RuleGroup?
local function TrimRuleGroup(g)
    -- returns nil if there are not enough matching spells loaded
    -- for this to be a meaningful rule.
    if not g then return end

    ---@type Rule[]
    local rule_working_list = {}

    for _, rule in pairs(g.rules) do
        local seen = {}
        ---@type string[]
        local spell_working_list = {}
        for _, spell_name in pairs(rule.spells) do
            if not seen[spell_name] then
                if CheckSpellExists(spell_name) then
                    table.insert(spell_working_list, spell_name)
                end
                seen[spell_name] = true
            end
        end
        if ArrayRulesMinimum[rule.kind] <= #spell_working_list then
            rule.spells = spell_working_list
            table.insert(rule_working_list, rule)
        end
    end

    if #rule_working_list == 0 then return end
    g.rules = rule_working_list
    return g
end

---@param config SLFrameworkConfig
---@return RuleGroup[]
local function GetActiveRules(config)
    ---@type RuleGroup[]
    local working_table = {}
    local loaded_cache = {}
    local valid_namespaces = {}
    for _, namespace in pairs(config.user_rule_files) do
        valid_namespaces[namespace] = true
    end
    for _, namespaced_name in pairs(config.active_user_rules) do

        local namespace, localname = namespaced_name:match("^([%W]+):([%W]+)$")
        if not valid_namespaces[namespace] then
            Ext.Utils.PrintWarning(missing_rule_messages["namespace"]:format(namespaced_name, namespace))
        end

        local namespaced_rules = loaded_cache[namespace]
        if not namespaced_rules then
            namespaced_rules = LoadRulesFromFile(namespace)
            if not namespaced_rules then
                valid_namespaces[namespace] = nil
            end
        end

        if namespaced_rules then
            local g = namespaced_rules[localname]
            local trimmed_g = TrimRuleGroup(g)
            if trimmed_g then
                table.insert(working_table, trimmed_g)
            else
                Ext.Utils.PrintWarning(missing_rule_messages["name"]:format(localname, namespace))
            end
        end
    end

    return working_table
end


---@param spell_list string[]
---@return table<string, boolean>
local function GetValidSpellTable(spell_list)
    local seen = {}
    ---@type table<string, boolean>
    local working_table = {}
    for _, spell in pairs(spell_list) do
        if seen[spell] == nil then
            if CheckSpellExists(spell) then
                working_table[spell] = true
            end
            seen[spell] = true
        end
    end
    return working_table
end

local function check_filter(rg, spell_table)
    local failed_filter = false
    if #rg.spell_filters > 0 then
        for _, filter in pairs(rg.spell_filters) do
            if filter.kind == "has_all" then
                for _, spell in pairs(filter.spells) do
                    if not spell_table[spell] then failed_filter = true end
                end
            elseif filter.kind == "has_any" then
                failed_filter = true
                for _, spell in (filter.spells) do
                    if spell_table[spell] then failed_filter = false end
                end
            elseif filter.kind == "has_none" then
                for _, spell in (filter.spells) do
                    if spell_table[spell] then failed_filter = true end
                end
            else
                error("wtf...")
            end
        end
    end
    return not failed_filter
end

---@param passive_data any
---@param groups RuleGroup[]
function ApplyRuleGroupsToPassiveBoosts(passive_data, groups)

    -- add isn't supported on passives

    local pass_through = {}
    local unlock = {}
    local seen = {}

    for str in passive_data.Boosts:gmatch("([^;]+)") do
        local unlocks_spell = str:match("UnlockSpell%(([^,%)])")
        if unlocks_spell then
            if unlock[unlocks_spell] == nil then
                unlock[unlocks_spell] = str
                table.insert(seen, str)
            end
        else
            table.insert(pass_through, str)
        end
    end

    local spell_table = GetValidSpellTable(seen)

    for _, rg in pairs(groups) do
        if check_filter(rg, spell_table) then
            for _, rule in pairs(rg.rules) do
                if rule.kind == "prefer" then
                    local seen_any = false
                    for _, spell in pairs(rule.spells) do
                        if spell_table[spell] then
                            if not seen_any then
                                unlock[rule.spells[1]] = unlock[spell]:replace(spell,rule.spells[1])
                                seen_any = true
                            end
                            spell_table[spell] = nil
                        end
                    end
                    if seen_any then spell_table[rule.spells[1]] = true end
                end
            end
        end
    end

    for _, rg in pairs(groups) do
        if check_filter(rg, spell_table) then
            for _, rule in pairs(rg.rules) do
                if rule.kind == "remove" then
                    for _, spell in pairs(rule.spells) do
                        spell_table[spell] = nil
                    end
                end
            end
        end
    end

    for spell, _ in pairs(spell_table) do
        if unlock[spell] then
            table.insert(pass_through, unlock[spell])
        end
    end

    passive_data.Boosts = table.concat(pass_through, ";")

end


---@param spell_list string[]
---@param groups RuleGroup[]
---@return string[]
local function ApplyRuleGroupsToLists(spell_list, groups)
    local spell_table = GetValidSpellTable(spell_list)

    --- rules are prioritized by type for predictable behavior
    local to_add = {}
    for _, rg in pairs(groups) do
        if check_filter(rg, spell_table) then
            for _, rule in pairs(rg.rules) do
                if rule.kind == "add" then
                    for _, spell in pairs(rule.spells) do
                        to_add[spell] = true
                    end
                end
            end
        end
    end
    for spell, _ in pairs(to_add) do spell_table[spell] = true end

    for _, rg in pairs(groups) do
        if check_filter(rg, spell_table) then
            for _, rule in pairs(rg.rules) do
                if rule.kind == "prefer" then
                    local seen_any = false
                    for _, spell in pairs(rule.spells) do
                        if spell_table[spell] then
                            seen_any = true
                            spell_table[spell] = nil
                        end
                    end
                    if seen_any then spell_table[rule.spells[1]] = true end
                end
            end
        end
    end

    for _, rg in pairs(groups) do
        if check_filter(rg, spell_table) then
            for _, rule in pairs(rg.rules) do
                if rule.kind == "remove" then
                    for _, spell in pairs(rule.spells) do
                        spell_table[spell] = nil
                    end
                end
            end
        end
    end

    local ret = {}
    for spell, _ in pairs(spell_table) do table.insert(ret, spell) end
    table.sort(ret, SpellSortFunc)
    return ret
end

---@return table<string,table<string, true>>, table<string,table<string, true>>
function GetListsAndPassives()
    ---@type table<string,table<string, true>>
    local spell_lists = {}
    ---@type table<string,table<string, true>>
    local passives = {}

    local prog_to_class = {}

    for class_uuid, desc in StaticDataIterator("ClassDescription") do
        prog_to_class[desc.ProgressionTableUUID] = class_uuid
        spell_lists[class_uuid] = {}
        passives[class_uuid] = {}
    end

    for _, pd in StaticDataIterator("Progression") do
        local class_uuid = prog_to_class[pd.TableUUID]
        if class_uuid then
            for _, this_select in ipairs(pd["AddSpells"]) do
                spell_lists[class_uuid][this_select.SpellUUID] = true
            end
            for _, this_select in ipairs(pd["SelectSpells"]) do
                spell_lists[class_uuid][this_select.SpellUUID] = true
            end

            local passives_added = pd.PassivesAdded or ""
            for passive in StringSplit(passives_added, ";", true) do
                passives[class_uuid][passive] = true
            end

            for _, this_select in ipairs(pd["SelectPassives"]) do
                local passive_list = Ext.StaticData.Get(this_select.UUID, "PassiveList")
                if passive_list then
                    for passive in passive_list.Passives do
                        passives[class_uuid][passive] = true
                    end
                end
            end

        end
    end

    return spell_lists, passives
end

---@class (exact) SCG
---@field class table<string, RuleGroup[]>
---@field passive table<string, RuleGroup[]>
---@field spell_list table<string, RuleGroup[]>

---@class (exact) WCG
---@field class RuleGroup[]
---@field passive RuleGroup[]
---@field spell_list RuleGroup[]


---@param rules RuleGroup[]
---@return SCG, WCG
local function grouped_by_scope_id(rules)
    ---@type SCG
    local grouped = {class = {}, passive = {}, spell_list = {}}
    ---@type WCG
    local wildcards = {class = {}, passive = {}, spell_list = {}}

    for _, rg in pairs(rules) do
        for scope_name, _ in pairs(IsScope) do
            if rg.wildcards[scope_name] then
                table.insert(wildcards[scope_name], rg)
            else
                for uuid, _ in rg.scopes[scope_name] do
                    local t = grouped[scope_name][uuid] or {}
                    table.insert(t, rg)
                    grouped[scope_name][uuid] = t
                end
            end
        end

    end

    return grouped, wildcards
end


function ModifyLists()

    local ok, config = pcall(LoadUserSettings)
    if not ok then
        Ext.Log.PrintError(config)
        return
    end

    local active_rules = GetActiveRules(config)
    local sc_groups, wildcards = grouped_by_scope_id(active_rules)
    local spell_lists_by_class, passives_by_class = GetListsAndPassives()

    --- avoid modifying repeating alterations
    --- use class data to augment spell list and passive rules

    for _, rg in pairs(wildcards.class) do
        for _class_uuid, spell_lists in pairs(spell_lists_by_class) do
            for sl_uuid, _ in pairs(spell_lists) do
                local groups = sc_groups.spell_list[sl_uuid] or {}
                table.insert(groups, rg)
                sc_groups.spell_list[sl_uuid] = groups
            end
        end

        for _class_uuid, passives in pairs(spell_lists_by_class) do
            for passive, _ in pairs(passives) do
                local groups = sc_groups.passive[passive] or {}
                table.insert(groups, rg)
                sc_groups.passive[passive] = groups
            end
        end
    end

    for uuid, rules in pairs(sc_groups.class) do
        local spell_lists = spell_lists_by_class[uuid]
        if spell_lists then
            for sl_uuid, _ in pairs(spell_lists) do
                local groups = sc_groups.spell_list[sl_uuid] or {}
                for _, rg in pairs(rules) do table.insert(groups, rg) end
                sc_groups["spell_list"][sl_uuid] = groups
            end
        end

        local passives = passives_by_class[uuid]
        if passives then
            for passive, _ in pairs(passives) do
                local groups = sc_groups["passive"][passive] or {}
                for _, rg in pairs(rules) do table.insert(groups, rg) end
                sc_groups["passive"][passive] = groups
            end
        end
    end

    for uuid, sl in StaticDataIterator("SpellList") do
        local groups = sc_groups.spell_list[uuid] or {}
        for _, rg in pairs(wildcards.spell_list) do
            table.insert(groups, rg)
        end
        --- do this unconditionally, it includes a bugfix
        --- related to not having enough spells to select
        --- when "missing" spells even when we didnt cause it.
        sl.Spells = ApplyRuleGroupsToLists(sl.Spells, groups)
    end

    for name, stats in StatsIterator("PassiveData") do
        local groups = sc_groups.passive[name] or {}
        for _, rg in pairs(wildcards.passive) do
            table.insert(groups, rg)
        end

        if #groups > 0 then ApplyRuleGroupsToPassiveBoosts(stats, groups) end

    end

end