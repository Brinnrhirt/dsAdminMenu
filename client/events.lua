-- Variables
ESX = exports['es_extended']:getSharedObject()


RegisterNetEvent("dsAdminMenu:client:killPlayer")
AddEventHandler("dsAdminMenu:client:killPlayer", function(ped)
    SetEntityHealth(PlayerPedId(), 0)
end)


RegisterNetEvent("dsAdminMenu:client:revive")
AddEventHandler("dsAdminMenu:client:revive", function(id)
    if Config.ReviveTrigger == 'esx_ambulancejob' then
        TriggerEvent('esx_ambulancejob:revive', id)
    elseif Config.ReviveTrigger == 'custom' then
        --Insert Custom Trigger Here
    end
end)
local function getVehicleFromVehList(hash)
	for _, v in pairs(Config.Vehicles) do
		if hash == v.hash then
			return v.model
		end
	end
end

RegisterNetEvent('dsAdminMenu:client:SaveCar', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)

    if veh ~= nil and veh ~= 0 then
        local plate = ESX.Game.GetVehicleProperties(veh).plate
        local props = ESX.Game.GetVehicleProperties(veh)
        local hash = props.model
        local vehname = getVehicleFromVehList(hash)
        if Config.Vehicles[vehname] ~= nil and next(Config.Vehicles[vehname]) ~= nil then
            TriggerServerEvent('dsAdminMenu:server:SaveCar', props, plate)
        else
            QBCore.Functions.Notify(_U("error.no_store_vehicle_garage"), 'error')
        end
    else
        QBCore.Functions.Notify(_U("error.no_vehicle"), 'error')
    end
end)


RegisterNetEvent('dsAdminMenu:client:SendReport', function(name, src, msg)
    TriggerServerEvent('dsAdminMenu:server:SendReport', name, src, msg)
end)
