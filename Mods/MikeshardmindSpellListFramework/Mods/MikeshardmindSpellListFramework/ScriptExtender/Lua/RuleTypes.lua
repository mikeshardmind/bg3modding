-- Denotes a set of spells to add
---@class (exact) AddRule
---@field kind "add"
---@field spells string[]

-- Denotes a set of spells to remove
---@class (exact) RemoveRule
---@field kind "remove"
---@field spells string[]

-- Denotes an ordered preference of spell implementations.
-- Swaps for the earliest implementation that exists.
---@class (exact) PreferRule
---@field kind "prefer"
---@field spells string[]

-- An ordered preference of spell implementations.
-- Keeps the earliest implementation already in each list.
-- This is NOT implemented yet, and may not end up being implemented.
-- Needs consideration on tradeoff of internal consistency vs overall consistency
-- that it creates to offer this. `prefer` rule is overall consistency
---@class (exact) PreferSeenRule
---@field kind "prefer_seen"
---@field spells string[]

---@alias Rule (AddRule | RemoveRule | PreferRule)

---@class (exact) SpellListScope
---@field kind "spell_list"
---@field uuid string

---@class (exact) ClassScope
---@field kind "class"
---@field uuid string

---@class (exact) SubclassScope
---@field kind "subclass"
---@field uuid string

---@class (exact) WildcardScope
---@field kind "*"

-- note: Not all scopes supported yet
---@alias Scope SpellListScope | WildcardScope

-- Checks that a list has certain spells or not
---@class (exact) HasAnySpellFilter
---@field kind "has_any"
---@field spells string[]

---@class (exact) HasAllSpellFilter
---@field kind "has_all"
---@field spells string[]

---@class (exact) HasNoneSpellFilter
---@field kind "has_none"
---@field spells string[]

---@alias SpellFilter HasAnySpellFilter | HasAllSpellFilter | HasNoneSpellFilter

---@class (exact) RuleGroup
---@field name string
---@field description string?
---@field rules Rule[]
---@field scopes Scope[]
---@field spell_filters SpellFilter[]
