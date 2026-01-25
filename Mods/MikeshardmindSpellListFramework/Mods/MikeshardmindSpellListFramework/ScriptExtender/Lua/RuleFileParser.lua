Ext.Require("Settings.lua")
Ext.Require("Utils.lua")

ArrayRulesMinimum = {
    ["add"] = 1,
    ["remove"] = 1,
    ["prefer"] = 2,
    ["has_any"] = 1,
    ["has_all"] = 1,
    ["has_none"] = 1,
    ["spell_list"] = 1,
    ["class"] = 1,
    ["passive"] = 1,
}

local RawText = {
    ["name"] = true,
    ["description"] = true,
}

local IsSpellFilter = {
    ["has_all"] = true,
    ["has_any"] = true,
    ["has_none"] = true,
}

---@type table<ScopeName, boolean>
IsScope = {
    ["spell_list"] = true,
    ["class"] = true,
    ["passive"] = true,
}

local IsRule = {
    ["add"] = true,
    ["remove"] = true,
    ["prefer"] = true,
}

---@param lines string[]
---@return RuleGroup
local function StructureGroup(lines)

    if lines[1] ~= "[rulegroup]" then
        error("Invalid rules file, data outside [rulegroup]")
    end

    ---@type RuleGroup
    local ret = {name = "", rules = {}, scopes = {}, spell_filters = {}, wildcards = {}}

    for sk, _ in pairs(IsScope) do
        ret.scopes[sk] = {}
    end

    for i = 2, #lines do
        ---@type string?
        local line = (lines[i]):match("^%s*(.-)%s*$")
        if line then
            local kind, data = line:match("^([^:]+):(.*)$")

            if not kind then
                error(("Invalid rulegroup entry %s"):format(line))
            end
            kind = kind:match("^%s*(.-)%s*$")
            data = data:match("^%s*(.-)%s*$")

            -- key-valued
            if RawText[kind] then
                ret[kind] = data
            end

            -- lists of things
            local required_number = ArrayRulesMinimum[kind]
            if required_number then
                local entries = {}
                for e in StringSplit(data, ",", true) do
                    e = e:match("^%s*(.-)%s*$")
                    if not e or #e == 0 then error(("Invalid rulegroup entry %s"):format(line)) end
                    table.insert(entries, e)
                end

                if #entries < required_number then
                    error(("Too few entries for %s"):format(kind))
                end

                if IsSpellFilter[kind] then
                    table.insert(ret.spell_filters, {kind = kind, spells = entries})
                elseif IsRule[kind] then
                    table.insert(ret.rules, {kind = kind, spells = entries})
                elseif IsScope[kind] then
                    local scopes = ret.scopes[kind] or {}
                    for _, e in pairs(entries) do
                        if e == "*" then ret.wildcards[kind] = true end
                        scopes[kind][e] = true
                    end
                    ret.scopes[kind] = scopes
                end
            end

        end
    end

    local scope_count = 0
    for scope_kind, _ in pairs(IsScope) do
        scope_count = scope_count + #ret.scopes[scope_kind]
    end
    if scope_count == 0 then
        for scope_kind, _ in pairs(IsScope) do
            ret.wildcards[scope_kind] = true
        end
    end
    for scope_kind, _ in pairs(IsScope) do
        if ret.wildcards[scope_kind] then ret.scopes[scope_kind] = {} end
    end

    if #ret.rules == 0 then error("rule group must have at least 1 rule") end
    return ret
end


local duplicated_entry_msg = "[SpellListFramework] Rules namespace %s contains duplicated rule named %s"


---@param text string
---@param namespace string
---@return table<string, RuleGroup>
local function ParseRules(text, namespace)

    local line_cache = {}
    ---@type table<string, RuleGroup>
    local groups = {}
    for s in text:gmatch("[^\r\n]+") do
        s = s:match("^%s*(.-)%s*$")
        if s == "[rulegroup]" then
            if #line_cache > 0 then
                local rg = StructureGroup(line_cache)
                if groups[rg.name] then
                    Ext.Utils.PrintWarning(duplicated_entry_msg:format(namespace, rg.name))
                end
                groups[rg.name] = rg
                line_cache = {}
            end
        end
        table.insert(line_cache, s)
    end

    if #line_cache > 0 then
        local rg = StructureGroup(line_cache)
        if groups[rg.name] then
            Ext.Utils.PrintWarning(duplicated_entry_msg:format(namespace, rg.name))
        end
        groups[rg.name] = rg
    end

    return groups
end


---@param namespace string
---@return table<string, RuleGroup>?
function LoadRulesFromFile(namespace)
    local filename = GetUserRuleFilePath(namespace)
    local text = Ext.IO.LoadFile(filename)
    if not text then return end

    local ok, result = pcall(ParseRules, text, namespace)
    if not ok then
        Ext.Utils.PrintWarning(("[SpellListFramework] Invalid rules file %s"):format(filename))
        Ext.Utils.PrintError(result)
    else
        return result
    end
end
