Ext.Require("utils.lua")

---@class (exact) ExpectedUserConfig
---@field user_rule_namespaces string[]
---@field active_user_rules string[]


---@class (exact) SLFrameworkConfig
---@field user_rule_files string[]
---@field active_user_rules string[]
---@field allow_mod_provided_rules boolean


---@type ExpectedUserConfig
local default_user_settings = {
    user_rule_namespaces = {"examples"},
    active_user_rules = {"examples:BladeCantrips"},
}

local function is_alphanum_string_array(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if type(t[i]) ~= "string" then return false end
        if t[i]:match("%W") then return false end
    end
    return true
end

local function is_array_of_col_sep_strings(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if type(t[i]) ~= "string" then return false end
        local lhs , rhs = t[i]:match("^([%W]+):([%W]+)$")
        if not (lhs and rhs) then return false end
    end
    return true
end


local expected_type_validators = {
    user_rule_files = is_alphanum_string_array,
    active_user_rules = is_array_of_col_sep_strings,
}

local fatal_config_format = [[
[SpellListFramework]Invalid settings in %s
Error: %s
Mod will not take effect.
]]

local expected_type_error_messages = {
    ["user_rule_files"] = "user_rule_files should be a list of strings",
    ["active_user_rules"] = "active_user_rules should be a list of strings",
}




---@return SLFrameworkConfig
function LoadUserSettings()
    local mod_dir = Ext.Mod.GetMod("c78d58b7-2bc5-4a13-975c-cd7cf9a42630").Info.Directory
    local filename = mod_dir .. "/user_settings.json"

    local file = Ext.IO.LoadFile(filename)
    local ret = file and Ext.Json.Parse(file) or {}
    local needs_rewrite = false
    ret.allow_mod_provided_rules = false  -- not implemented

    for key, value in pairs(default_user_settings) do
        if type(ret[key]) == "nil" then
            needs_rewrite = true
            ret[key] = DeepCopy(value)
        elseif not expected_type_validators[key] then
            local msg = fatal_config_format:format(filename, expected_type_error_messages[key])
            error(msg)
        end
    end

    if needs_rewrite then
        local d = Ext.Json.Stringify(ret)
        Ext.IO.SaveFile(filename, d)
    end
    return ret
end

---@param rule_file_name string
---@return string
function GetUserRuleFilePath(rule_file_name)
    local mod_dir = Ext.Mod.GetMod("c78d58b7-2bc5-4a13-975c-cd7cf9a42630").Info.Directory
    return ("%s/user_rules/%s.txt"):format(mod_dir, rule_file_name)
end


local example_text = [[
[rulegroup]
name: BladeCantrips
description: Add Blade Cantrips to anyone with any blade cantrip, trimming to preferences
spell_list: *
class: *
has_any: Target_BoomingBlade_5e, Target_BoomingBlade, Target_Sparking_Blade, Target_GreenFlameBlade, Target_BoomingBladeMove, Target_GreenFlameBlade
add: Target_BoomingBlade_5e, Target_BoomingBlade, Target_Sparking_Blade, Target_GreenFlameBlade, Target_BoomingBladeMove, Target_GreenFlameBlade
prefer: Target_BoomingBlade_5e, Target_BoomingBlade, Target_BoomingBladeMove

[rulegroup]
name: MindSliver
description: prefer mindsliver from 5eSpells, then Spells Extra, then Mystra's Spells
prefer: Target_MindSliver, Target_LHB_SEL_Mind_Sliver, Projectile_MindSliver
]]

function WriteExamples()
    local filename = GetUserRuleFilePath("examples")
    local file = Ext.IO.LoadFile(filename)
    if not file or file == "" then
        Ext.IO.SaveFile(filename, example_text)
    end
end