ItemCategory = {weapon = {"weapon_switchblade", "weapon_nightstick", "weapon_wrench", "weapon_battleaxe", "weapon_poolcue", "weapon_stone_hatchet", "weapon_pistol", "weapon_pistol_mk2", "weapon_combatpistol", "weapon_appistol", "weapon_stungun", "weapon_pistol50", "weapon_snspistol", "weapon_snspistol_mk2", "weapon_heavypistol", "weapon_vintagepistol", "weapon_flaregun", "weapon_marksmanpistol", "weapon_revolver", "weapon_revolver_mk2", "weapon_doubleaction", "weapon_raypistol", "weapon_ceramicpistol", "weapon_navyrevolver", "weapon_microsmg", "weapon_smg", "weapon_smg_mk2", "weapon_assaultsmg", "weapon_combatpdw", "weapon_machinepistol", "weapon_minismg", "weapon_raycarbine", "weapon_pumpshotgun", "weapon_pumpshotgun_mk2", "weapon_sawnoffshotgun", "weapon_assaultshotgun", "weapon_bullpupshotgun", "weapon_musket", "weapon_heavyshotgun", "weapon_dbshotgun", "weapon_autoshotgun", "weapon_assaultrifle", "weapon_assaultrifle_mk2", "weapon_carbinerifle", "weapon_carbinerifle_mk2", "weapon_advancedrifle", "weapon_specialcarbine", "weapon_specialcarbine_mk2", "weapon_bullpuprifle", "weapon_bullpuprifle_mk2", "weapon_compactrifle", "weapon_mg", "weapon_combatmg", "weapon_combatmg_mk2", "weapon_gusenberg", "weapon_sniperrifle", "weapon_heavysniper", "weapon_heavysniper_mk2", "weapon_marksmanrifle", "weapon_marksmanrifle_mk2", "weapon_rpg", "weapon_grenadelauncher", "weapon_grenadelauncher_smoke", "weapon_minigun", "weapon_firework", "weapon_railgun", "weapon_hominglauncher", "weapon_compactlauncher", "weapon_rayminigun", "weapon_grenade", "weapon_bzgas", "weapon_smokegrenade", "weapon_flare", "weapon_molotov", "weapon_stickybomb", "weapon_proxmine", "weapon_snowball", "weapon_pipebomb", "weapon_ball", "weapon_petrolcan", "weapon_fireextinguisher", "weapon_parachute", "weapon_hazardcan"},
                clothe = {},
                food = {},}

function CreateInventory(id)
    local self = {}
    self.inventory = {}
    self.maxWeight = 0
    self.weight = 0

    --- Loads the inventory data from the database.
    function self.loadInventory()
        local response = MySQL.prepare.await('SELECT `inventory`, `weight` FROM `inventory` WHERE `identifier` = ?', {
            id
        })

    end
    
    self.maxWeight = CalculMaxWeight(self)
    ---Saves the player's inventory to the database.
    function self.saveInventory()
        MySQL.update('UPDATE users SET inventory = ?, weight = ? WHERE identifier = ?', {
            self.inventory, self.weight, id
        }, function(affectedRows)
            if affectedRows == 0 then
                print("erreur lors de la sauvegarde d'un joueur(id du joueur : %s)".format(id))
            end
        end)
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


    --- Removes a specified quantity of an item from the inventory.
    --- @param item string The item to remove.
    --- @param amount number The quantity of the item to remove.
    function self.removeItem(item, amount)
        if item in self.inventory then
            if self.inventory[item] >= amount then
                self.inventory[item] = self.inventory[item] - amount
            else
                self.inventory[item] = 0
            end
        end
        self.weight = self.weight - amount * GetItemWeight(item)
    end


    --- return the ammount of a specified item
    --- @param item string the item to have the ammount
    function self.getItemAmount(item)
        return self.inventory[item]
    end

    --- Adds a specified amount of money to the player's inventory.
    --- @param amount number The amount of money to add.
    function self.addMoney(ammount)
        self:addItem("money", ammount)
    end

    -- Removes a specified amount of money from the player's inventory.
    --- @param ammount number The amount of money to remove.
    function self.removeMoney(ammount)
        self:removeItem("money", ammount)
    end

    



    return self
end