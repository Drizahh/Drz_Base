
function CreateInventory(id)
    local self = {}
    self.inventory = {}
    self.weight = 0


    --- Loads the inventory data from the database.
    function self.loadInventory()
        local response = MySQL.prepare.await('SELECT `inventory`, `weight` FROM `inventory` WHERE `identifier` = ?', {
            id
        })

    end

    --- Adds a specified quantity of an item to the inventory.
    --- @param item string The item to add.
    --- @param amount number The quantity of the item to add.
    function self.addItem(item, amount)
        if item in self.inventory then
            self.inventory[item] = self.inventory[item] + amount
        else
            self.inventory[item] = amount
        end
        self.weight = self.weight + amount * GetItemWeight(item)
    end

    return self
end