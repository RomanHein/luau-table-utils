--[[
    TableUtils.luau


--]]

--------------------------------------------------------------------------------
-- UTILS
--------------------------------------------------------------------------------

local TableUtils = {}

--[[
    Creates a deep copy of a table.
--]]
function TableUtils.copy<T>(target: T): T
    local result = table.create(#target)

    for key, value in target do
        if type(value) == "table" then
            result[key] = TableUtils.copy(value)
        else
            result[key] = value
        end
    end

    return result
end

--[[
    Fills missing entries of a table with entries of another table.
--]]
function TableUtils.reconcile<T, S>(target: T, source: S): T & S
    local result = TableUtils.copy(target)

    for key, value in source do
        if type(value) == "table" then
            if type(result[key]) == "table" then
                result[key] = TableUtils.reconcile(result[key], value)
            else
                result[key] = TableUtils.copy(value)
            end
        else
            result[key] = value
        end
    end

    return result
end

return TableUtils