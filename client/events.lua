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
	for _, v in pairs(VehiclesList) do
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
        if VehiclesList[vehname] ~= nil and next(VehiclesList[vehname]) ~= nil then
            TriggerServerEvent('dsAdminMenu:server:SaveCar', props, plate)
        else
            ESX.ShowNotification(_U("error.no_store_vehicle_garage"))
        end
    else
        ESX.ShowNotification(_U("error.no_vehicle"))
    end
end)


RegisterNetEvent('dsAdminMenu:client:SendReport', function(name, src, msg)
    TriggerServerEvent('dsAdminMenu:server:SendReport', name, src, msg)
end)


local performanceModIndices = {11,12,13,15,16}
function PerformanceUpgradeVehicle(vehicle, customWheels)
    customWheels = customWheels or false
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, modType) - 1
            SetVehicleMod(vehicle, modType, max, customWheels)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
        SetVehicleFixed(vehicle)
    end
end

RegisterNetEvent('dsAdminMenu:client:maxmodVehicle', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    PerformanceUpgradeVehicle(vehicle)
    ESX.ShowNotification(_U("info.max_mods"))
end)
