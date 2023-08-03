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


RegisterNetEvent('dsAdminMenu:client:SendReport', function(name, src, msg)
    TriggerServerEvent('dsAdminMenu:server:SendReport', name, src, msg)
end)
