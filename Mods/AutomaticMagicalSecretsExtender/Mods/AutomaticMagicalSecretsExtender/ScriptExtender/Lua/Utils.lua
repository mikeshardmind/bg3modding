
-- Contains structural typing for the fields used
-- not comprehensive, despite listing (exact) as it's intended
-- to limit api surface I should both use and care about

---@class (exact) ExtStaticData_SpellSelector
---@field SpellUUID string
---@field SelectorId string

---@class (exact) ExtStaticData_UUIDSelector
---@field UUID string

---@class (exact) ExtStaticData_Progression
---@field AddSpells ExtStaticData_SpellSelector[]
---@field SelectSpells ExtStaticData_SpellSelector[]
---@field PassivesAdded string
---@field SelectPassives ExtStaticData_UUIDSelector[]
---@field TableUUID string

---@class (exact) ExtStaticData_ClassDescription
---@field ProgressionTableUUID string
---@field ParentGuid string?
---@field SpellList string?

---@class (exact) ExtStaticData_SpellList
---@field Spells string[]

---@overload fun(kind: "ClassDescription"): fun(): string, ExtStaticData_ClassDescription
---@overload fun(kind: "Progression"): fun(): string, ExtStaticData_Progression
---@overload fun(kind: "SpellList"): fun(): string, ExtStaticData_SpellList
function StaticDataIterator(kind)
    local co = coroutine.create(
        function()
            for _, uuid in pairs(Ext.StaticData.GetAll(kind)) do
                coroutine.yield(uuid, Ext.StaticData.Get(uuid, kind))
            end
        end
    )
    return function()
        local _, uuid, data = coroutine.resume(co)
        return uuid, data
    end
end


---@generic T
---@param t T[]
---@return fun(): T
function ListIter(t)
    local i = 0
    local n = #t
    return function ()
        i = i + 1
        if i <= n then return t[i] end
    end
end

---@generic T
---@param t table<T, true>
---@return fun(): T
function SetIter(t)
     local co = coroutine.create(
        function()
            for value, _ in pairs(t) do
                coroutine.yield(value)

            end
        end
    )
    return function()
        local _, value = coroutine.resume(co)
        return value
    end
end


---@generic T
---@param prod fun(): T
---@param seen table<T, true>?
---@return fun(): T
function Unique(prod, seen)
    seen = seen or {}
    local co = coroutine.create(
        function()
            for value in prod do
                if not seen[value] then
                    coroutine.yield(value)
                    seen[value] = true
                end
            end
        end
    )

    return function()
        local _, value = coroutine.resume(co)
        return value
    end
end

---@generic T
---@param t T[]
---@param value T
---@param cmp fun(T, T): boolean
function BinInsert(t, value, cmp)
    local front,back,mid,state = 1,#t,1,0
    while front <= back do
        mid = (front+back) // 2
        if cmp( value,t[mid] ) then
        back,state = mid - 1,0
        else
        front,state = mid + 1,1
        end
    end
    table.insert( t,(mid+state),value )
    return (mid+state)
end