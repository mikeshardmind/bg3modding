Ext.Require("Utils.lua")


---@param rg RuleGroup
---@return string
function RuleGroupToString(rg)

    local buffer = {"[rulegroup]"}

    table.insert(buffer, "name: " ..rg.name)
    if rg.description then
        table.insert(buffer, "description: " ..rg.description)
    end

    for _, rule in pairs(rg.rules) do
        local spells = table.concat(rule.spells, ",")
        table.insert(buffer, rule.kind .. ": " ..spells)
    end

    for scope_kind, scope_data in pairs(rg.scopes) do
        if rg.wildcards[scope_kind] then
            table.insert(buffer, scope_kind .. ": *")
        else
            local scopes = table.concat(scope_data, ",")
            table.insert(buffer, scope_kind .. ": " ..scopes)
        end
    end

    for _, filter in pairs(rg.spell_filters) do
        local spells = table.concat(filter.spells, ",")
        table.insert(buffer, filter.kind .. ": " ..spells)
    end

    return table.concat(buffer, "\n")
end