--[[ 
    Hi, Here you can edit the permissions (if you didn't already on the config)
    or delete some of the commands, thank you for buying my script!
]]
local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterCommand('maxmods', Config.Permissions['maxmods'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:maxmodVehicle', src)
end, false)

ESX.RegisterCommand('fix', Config.Permissions['fix'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:FixVehicle', src)
end, false)

ESX.RegisterCommand('blips', Config.Permissions['kick'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:toggleBlips', src)
end, false)

ESX.RegisterCommand('names', Config.Permissions['names'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:toggleNames', src)
end, false)

ESX.RegisterCommand('coords', Config.Permissions['coords'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:ToggleCoords', src)
end, false)

ESX.RegisterCommand('noclip', Config.Permissions['noclip'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:ToggleNoClip', src)
end, false)

ESX.RegisterCommand('admin', Config.Permissions['adminmenu'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:openMenu', src)
end, false)

ESX.RegisterCommand('admincar', Config.Permissions['admincar'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:SaveCar', src)
end, false)

ESX.RegisterCommand('kickall', 'admin', function(xPlayer, args, showError)
    local src = xPlayer.source
    if src > 0 then
        local reason = table.concat(args, ' ')
        if reason and reason ~= '' then
            for _, v in pairs(ESX.GetPlayers()) do
                local Player = ESX.GetPlayerFromId(v)
                if Player then
                    DropPlayer(Player.source, reason)
                end
            end
        else
            TriggerClientEvent('esx:showNotification', src, Lang["no_reason_specified"])
        end
    else
        for _, v in pairs(ESX.GetPlayers()) do
            local Player = ESX.GetPlayerFromId(v)
            if Player then
                DropPlayer(Player.source, Lang["server_restart"] .. Config.Discord)
            end
        end
    end
end, false)

ESX.RegisterCommand('setspeed', Config.Permissions['setspeed'], function(xPlayer, args, showError)
    local speed = args[1]
    if speed ~= nil then
        TriggerClientEvent('dsAdminMenu:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('esx:showNotification', source, Lang["failed_set_speed"])
    end
end, false)

ESX.RegisterCommand('vector2', Config.Permissions['vector2'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:copyToClipboard', src, 'coords2')
end, false)

ESX.RegisterCommand('vector3', Config.Permissions['vector3'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:copyToClipboard', src, 'coords3')
end, false)

ESX.RegisterCommand('vector4', Config.Permissions['vector4'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:copyToClipboard', src, 'coords4')
end, false)

ESX.RegisterCommand('heading', Config.Permissions['heading'], function(xPlayer, args, showError)
    local src = xPlayer.source
    TriggerClientEvent('dsAdminMenu:client:copyToClipboard', src, 'heading')
end, false)

ESX.RegisterCommand('staffchat', Config.Permissions['staffchat'], function(xPlayer, args, showError)
    local msg = table.concat(args, ' ')
    local source = xPlayer.source
    local name = GetPlayerName(source)

    local plrs = ESX.GetExtendedPlayers()

    for i = 1, #plrs, 1 do
        local plr = plrs[i]
        if havePermission(plr, Config.Permissions['staffchat']) then
            --[[ 
                Change to the Trigger it corresponds to your chat
                Values:
                plr (source)
                name (name of the person who sent the message)
                msg (message)
            ]]
            TriggerClientEvent('chat:addMessage', plr, {
                color = {255, 0, 0},
                multiline = true,
                args = {_U('info.staffchat')..name, msg}
            })
        end
    end
end, false)