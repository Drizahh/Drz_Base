

function CreatePlayer(id)
    local response = MySQL.prepare.await('SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = ?', {
        id
    })

    local self = {}
    if response then
        self.name = response.firstname
        self.lastname = response.lastname
    else

    end
    self.inventory = CreateInventory(id)


    function self.Getter(value) --value est un string pour pouvoir etre une cle exiistante
        return self[value]
    end


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


    function self.triggerEvent(eventName, ...)
        TriggerClientEvent(eventName, self.source, ...)
    end


    function self.setcoords()

    end

end