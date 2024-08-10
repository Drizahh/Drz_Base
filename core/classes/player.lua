

function CreatePlayer(id)
    local response = MySQL.prepare.await('SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = ?', {
        id
    })
    -- TODO la recuperation des donnes du joueur s lors de son chargement par le core
    local self = {}
    if response then
        self.name = response.firstname
        self.lastname = response.lastname
    else

    end
    self.inventory = CreateInventory(id)

    ---Getter for any attribut of the player classes
    ---@param param string the name of the attributs 
    function self.Getter(param) --value est un string pour pouvoir etre une cle exiistante
        return self[param]
    end

    ---Setter for every attribut of the player's classes 
    ---@param param string the paramaters who want to be change
    ---@param value string | int the new value for the chossen paramaters
    function self.Setter(param, value)
        local case = {
            ['name'] = function ( )
                        self.name = value
            end,
            ['lastname'] = function ( )
                            self.lastname = value
            end,
            -- ajouter les setter ici dans le case 
        }
        case[param]()
    end

    ---Trigger client sidded event with player src
    ---@param eventName string: name of the event who want to be execute by the client
    function self.triggerEvent(eventName, ...)
        TriggerClientEvent(eventName, self.source, ...)
    end

   ---Sets the player's coordinates and heading.
   ---@param co vector4d |vector3d: The new coordinates and (heading if vector4d) for the player.
   ---@return boolean: the method executed correctly
    function self.setCoords(co)
        local ped <const> = GetPlayerPed(self.id)
        local h = (type(co) == vector4 and co ) or GetEntityHeading(peds)
        SetEntityCoords(ped,co.xyz, false, false,false, false)
        SetEntityHeading(ped, h)
        return true
    end

    ---Gets the player's coordinates and heading.
    ---@param heading bool: If true, returns a vector4d with the heading. If false, returns a vector3d with only the coordinates.
    ---@return vector3d | vector4d: The player's coordinates and heading.
    function self.getCoords(heading)
        local peds<const> = GetPlayerPed(self.id)
        local vector1 = GetEntityCoords(peds)
        local vector2 = vector4(vector1.xyz,GetEntityHeading(peds))
        local res = (heading and vector2) or vector1
        return res
    end

    ---@param reason string: the reason of the kick
    ---@return void
    function self.kick(reason)
        DropPlayer(self.id, reason)
    end
    



    return self
end