-- Variables
ESX = exports['es_extended']:getSharedObject()

local lastSpectateCoord = nil
local isSpectating = false

RegisterNetEvent("dsAdminMenu:client:killPlayer")
AddEventHandler("dsAdminMenu:client:killPlayer", function(ped)
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('dsAdminMenu:client:spectate', function(targetPed)
    local myPed = PlayerPedId()
    local targetplayer = GetPlayerFromServerId(targetPed)
    local target = GetPlayerPed(targetplayer)
    if not isSpectating then
        isSpectating = true
        SetEntityVisible(myPed, false) -- Set invisible
        SetEntityCollision(myPed, false, false) -- Set collision
        SetEntityInvincible(myPed, true) -- Set invincible
        NetworkSetEntityInvisibleToNetwork(myPed, true) -- Set invisibility
        lastSpectateCoord = GetEntityCoords(myPed) -- save my last coords
        NetworkSetInSpectatorMode(true, target) -- Enter Spectate Mode
    else
        isSpectating = false
        NetworkSetInSpectatorMode(false, target) -- Remove From Spectate Mode
        NetworkSetEntityInvisibleToNetwork(myPed, false) -- Set Visible
        SetEntityCollision(myPed, true, true) -- Set collision
        SetEntityCoords(myPed, lastSpectateCoord) -- Return Me To My Coords
        SetEntityVisible(myPed, true) -- Remove invisible
        SetEntityInvincible(myPed, false) -- Remove godmode
        lastSpectateCoord = nil -- Reset Last Saved Coords
    end
end)

RegisterNetEvent('dsAdminMenu:client:FixVehicle')
AddEventHandler('dsAdminMenu:client:FixVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			CreateThread(function()
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ESX.ShowNotification(_U('success.veh_repaired'))
			end)
		end
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
