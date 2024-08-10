

 ---    Retrieves the weight of a specific item from the inventory database.
 ---@param item string - The identifier of the item to retrieve the weight for.
 ---@return int - A table containing the inventory and weight of the item.
function GetItemWeight(item)
    local response = MySQL.prepare.await('SELECT `inventory`, `weight` FROM `inventory` WHERE `identifier` = ?', {
        id
    })
    return responce
end


function Sizeof(table)
    local cpt = 0
    for _, _ in pairs(table) do
        cpt = cpt + 1
    end
    return cpt
end

function TableContainKey(t, value)
    for _,k in pairs(t) do 
        if k == value then
            return true
        end
    end
    return false
end


--- Calculates the maximum weight capacity based on the type of container in the inventory.
--- @param inv The inventory object to check.
--- @return The maximum weight capacity.
function CalculMaxWeight(inv)
    local maxWeight = 0
    if TableContainKey(inventory.inventory, "suitecase") then
        maxWeight = 80
    elseif TableContainKey(inventory.inventory, "backpack") then
        maxWeight = 60
    else
        maxWeight = 40
    end
    return maxWeight
end