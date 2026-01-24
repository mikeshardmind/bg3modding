Ext.Require("Spells.lua")
Ext.Require("Settings.lua")
Ext.Require("RuleFileParser.lua")


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
---@return table<string, RuleGroup>
local function GetActiveRules(config)
    ---@type table<string, RuleGroup>
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
                working_table[namespaced_name] = g
            else
                Ext.Utils.PrintWarning(missing_rule_messages["name"]:format(localname, namespace))
            end
        end
    end

    return working_table
end


---@class GroupedByScope
---@field all RuleGroup[]
---@field spell_list table <string, RuleGroup[]>

---@param  groups_by_id table<string, RuleGroup>
---@return GroupedByScope
local function RuleGroupsByScope(groups_by_id)
    local ret = {
        ["all"] = {},
        ["spell_list"] = {}
    }
    for _, rg in pairs(groups_by_id) do
        for _, scope in pairs(rg.scopes) do
            if scope.kind == "*" then
                table.insert(ret["all"], rg)
            else
                local s = ret[scope.kind][scope.uuid] or {}
                table.insert(s, rg)
                ret[scope.kind][scope.uuid] = s
            end
        end
    end
    return ret
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



---@param spell_list string[]
---@param groups RuleGroup[]
---@return string[]
local function ApplyRuleGroups(spell_list, groups)
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
                        to_add[spell] = nil
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


function ModifyLists()

    local ok, config = pcall(LoadUserSettings)
    if not ok then
        Ext.Log.PrintError(config)
        return
    end

    local active_rules = GetActiveRules(config)
    local groups_by_scope = RuleGroupsByScope(active_rules)

    for _, uuid in pairs(Ext.StaticData.GetAll("SpellList")) do
        local sl = Ext.StaticData.Get(uuid, "SpellList")
        if sl then
            local groups = groups_by_scope["spell_list"][uuid] or {}
            for _, rg in pairs(groups_by_scope.all) do
                table.insert(groups, rg)
            end
            sl.Spells = ApplyRuleGroups(sl.Spells, groups)
        end
    end
end