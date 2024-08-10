


function CreateVehicle(id)
    self ={}
    self.vehicle = nil
    self.model = adder
    self.health = 0
    self.LicensePlateStyle = 0
    self.VehicleClass = "Super
    self.VehicleColor = "WornRed"
    self.VehicleLockStatus = 10
    self.VehicleWindowTint = nil
    self.Armor = 0
    self.Brakes = 0
    self.Engine = 0
    self.Suspension = 0
    self.Transmission = 0
    self.Horns = 0
    self.FrontWheel = 0
    self.RearWheel = 0


    function self.loadVehicle()


    end

    function self.spawnVehicle(co)
        RequestModel(GetHashKey(self.model))
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end

        local vehicle = CreateVehicle(GetHashKey(self.model), co)
        SetVehicleModKit(vehicle, 1)
        for i,k in pairs(self.mods) do
            SetVehicleMod(vehicle, modType, self.mods.k, false)
        end
        self.vehicle = vehicle
        return vehicle

    end


end