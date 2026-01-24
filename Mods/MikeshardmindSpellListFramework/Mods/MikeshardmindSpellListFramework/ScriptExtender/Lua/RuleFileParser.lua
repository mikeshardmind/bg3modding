Ext.Require("Settings.lua")

ArrayRulesMinimum = {
    ["add"] = 1,
    ["remove"] = 1,
    ["prefer"] = 2,
    ["has_any"] = 1,
    ["has_all"] = 1,
    ["has_none"] = 1,
    ["scope"] = 1,
}

local IsUUIDScopeName = {
    ["spell_list"] = true,
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

local IsScope = {["scope"] = true}

local IsRule = {
    ["add"] = true,
    ["remove"] = true,
    ["prefer"] = true,
}

-- only neded because I'm rejecting `,,`
local function split(s, sep, plain)
   local start = 1
   local done = false
   local function pass(i, j, ...)
      if i then
         local seg = s:sub(start, i - 1)
         start = j + 1
         return seg, ...
      else
         done = true
         return s:sub(start)
      end
   end
   return function()
      if done then
         return
       end
      if sep == '' then
         done = true
         return s
      end
      return pass(s:find(sep, start, plain))
   end
end


---@param lines string[]
---@return RuleGroup
local function StructureGroup(lines)

    if lines[1] ~= "[rulegroup]" then
        error("Invalid rules file, data outside [rulegroup]")
    end

    ---@type RuleGroup
    local ret = {name = "", rules = {}, scopes = {}, spell_filters = {}}

    for i = 2, #lines do
        ---@type string?
        local line = (lines[i]):match("^%s*(.-)%s*$")
        if line then
            local kind, data = line:match("([^:]+):(.*)")

            if not kind then
                error(("Invalid rulegroup entry %s"):format(line))
            end

            -- key-valued
            if RawText[kind] then
                ret[kind] = data
            end

            -- lists of things
            local required_number = ArrayRulesMinimum[kind]
            if required_number then
                local entries = {}
                for e in split(data, ",", 1) do
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
                end
            end

            -- scopes
            if IsScope[kind] then
                data = data:match("^%s*(.-)%s*$")
                if data == "*" then
                    table.insert(ret.scopes, {kind="*"})
                else
                    local scope_kind, scope_uuid = data:match("^([%W]+):([%W]+)$")
                    if scope_kind and scope_uuid and IsUUIDScopeName[scope_kind] then
                        table.insert(ret.scopes, {kind=scope_kind, uuid=scope_uuid})
                    else
                        error(("Invalid scope: %s"):format(data))
                    end
                end
            end
        end
    end

    -- implicit apply to everything
    if #ret.scopes == 0 then table.insert(ret.scopes, {kind="*"}) end
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
            table.insert(line_cache, s)
        end
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
    else
        return result
    end
end
