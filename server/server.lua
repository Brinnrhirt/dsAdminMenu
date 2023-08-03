local ESX = exports['es_extended']:getSharedObject()
local frozen = false
local players = {}
  
local function onPlayerConnecting(name, _, deferrals)
    local src = source
    local license
    local identifiers = GetPlayerIdentifiers(src)
    deferrals.defer()

    -- Mandatory wait
    Wait(0)

    deferrals.update(string.format(_U('info.checking_ban', name)))

    for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    -- Mandatory wait
    Wait(2500)

    local isBanned, Reason = IsPlayerBanned(src)
    local isLicenseAlreadyInUse = IsLicenseInUse(license)

    Wait(2500)

    deferrals.update(string.format(_U('info.join_server', name)))

    if not license then
      deferrals.done(_U('error.no_valid_license'))
    elseif isBanned then
        deferrals.done(Reason)
    elseif isLicenseAlreadyInUse then
        deferrals.done(_U('error.duplicate_license'))
    end

    deferrals.done()

end

AddEventHandler('playerConnecting', onPlayerConnecting)

-- Get Players
ESX.RegisterServerCallback('test:getplayers', function(_, cb) -- WORKS
    cb(players)
end)

ESX.RegisterServerCallback('dsAdminMenu:server:getrank', function(source, cb)
    local src = source
    if havePermission(src, Config.Permissions['giveperms']) then
        cb(true)
    else
        cb(false)
    end
end)

-- Events
RegisterNetEvent('dsAdminMenu:server:GetPlayersForBlips', function()
    local src = source
    TriggerClientEvent('dsAdminMenu:client:Show', src, players)
end)

RegisterNetEvent('dsAdminMenu:server:kill', function(player)
    local src = source
    if havePermission(src, Config.Permissions['kill'])   then
        TriggerClientEvent("dsAdminMenu:killPlayer", player.id)
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterNetEvent('dsAdminMenu:server:revive', function(player)
    local src = source
    if havePermission(src, Config.Permissions['revive'])   then
        TriggerClientEvent('dsAdminMenu:client:revive', player.id)
        if Config.EnableWebhooks then
            TriggerEvent('dsAdminMenu:server:CreateLog', 'revive', 'Player Revived', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        end
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterNetEvent('dsAdminMenu:server:kick', function(player, reason)
    local src = source
    if havePermission(src, Config.Permissions['kick'])   then
        if Config.EnableWebhooks then
            TriggerEvent('dsAdminMenu:server:CreateLog', 'kick', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        end
        DropPlayer(player.id, _U('kicked_server') .. ':\n' .. reason .. '\n\n' .. _U('check_discord', Config.Discord))
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterNetEvent('dsAdminMenu:server:spectate', function(player)
    local src = source
    if havePermission(src, Config.Permissions['spectate'])  then
        local targetped = GetPlayerPed(player.id)
        local coords = GetEntityCoords(targetped)
        TriggerClientEvent('dsAdminMenu:client:spectate', src, player.id, coords)
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterServerEvent('dsAdminMenu:giveWeapon', function(weapon)
    local src = source
    local Player =  ESX.GetPlayerFromId(src)
    if Config.Inventory == 'ox_inventory' then
        -- Didn't found the ox trigger xD
        Player.addInventoryItem(weapon, 1)
    elseif Config.Inventory == 'custom' then
        Player.addInventoryItem(weapon, 1)
        -- Insert Code Here
    end
end)

RegisterNetEvent('dsAdminMenu:server:SaveCar', function(vehicleProps, plate)
    local src = source
    local Player =  ESX.GetPlayerFromId(src)
    local result = MySQL.query.await('SELECT plate FROM owned_vehicles WHERE plate = ?', { plate })
    if result[1] == nil then
        MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)', {
            Player.identifier,
            plate,
            json.encode(vehicleProps)
        })
        TriggerClientEvent('esx:showNotification', src, _U("success.success_vehicle_owner"))
    else
        TriggerClientEvent('esx:showNotification', src, _U("error.failed_vehicle_owner"))
    end
end)


RegisterNetEvent('dsAdminMenu:server:freeze', function(player)
    local src = source
    if havePermission(src, Config.Permissions['freeze'])  then
        local target = GetPlayerPed(player.id)
        if not frozen then
            frozen = true
            FreezeEntityPosition(target, true)
        else
            frozen = false
            FreezeEntityPosition(target, false)
        end
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterNetEvent('dsAdminMenu:server:goto', function(player)
    local src = source
    if havePermission(src, Config.Permissions['goto']) then
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(GetPlayerPed(player.id))
        SetEntityCoords(admin, coords)
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterNetEvent('dsAdminMenu:server:intovehicle', function(player)
    local src = source
    if havePermission(src, Config.Permissions['intovehicle'])  then
        local admin = GetPlayerPed(src)
        local targetPed = GetPlayerPed(player.id)
        local vehicle = GetVehiclePedIsIn(targetPed,false)
        local seat = -1
        if vehicle ~= 0 then
            for i=0,8,1 do
                if GetPedInVehicleSeat(vehicle,i) == 0 then
                    seat = i
                    break
                end
            end
            if seat ~= -1 then
                SetPedIntoVehicle(admin,vehicle,seat)
                TriggerClientEvent('esx:showNotification', src, _U('entered_vehicle'))
            else
                TriggerClientEvent('esx:showNotification', src, _U('info.banned', "Exploiting"))
            end
        end
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

-- Events
RegisterNetEvent('dsAdminMenu:server:GetPlayersForBlips', function()
    local src = source
    TriggerClientEvent('dsAdminMenu:client:Show', src, players)
end)

RegisterNetEvent('dsAdminMenu:server:ban', function(player, time, reason)
    local src = source
    if havePermission(src, Config.Permissions['ban'])  then
        time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date('*t', banTime)
        MySQL.insert('INSERT INTO bans (name, license, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(player.id),
            GetIdentifiers(player.id,'license'),
            GetIdentifiers(player.id, 'ip'),
            reason,
            banTime,
            GetPlayerName(src)
        })
        if Config.EnableWebhooks then
            TriggerEvent('dsAdminMenu:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        end
        if banTime >= 2147483647 then
            DropPlayer(player.id, _U('info.banned') .. '\n' .. reason .. _U('info.ban_perm') .. Config.Discord)
        else
            DropPlayer(player.id, _U('info.banned') .. '\n' .. reason .. _U('info.ban_expires') .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. Config.Discord)
        end
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('dsAdminMenu:server:bring', function(player)
    local src = source
    if havePermission(src, Config.Permissions['bring']) then
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(admin)
        local target = GetPlayerPed(player.id)
        SetEntityCoords(target, coords)
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterNetEvent('dsAdminMenu:server:inventory', function(player)
    local src = source
    if havePermission(src, Config.Permissions['inventory']) then
        if Config.Inventory == 'ox_inventory' then
            exports.ox_inventory:forceOpenInventory(src, 'player', player.id)
        elseif Config.Inventory == 'custom' then
            --Insert Custom Trigger Here
        end
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterNetEvent('dsAdminMenu:server:cloth', function(player)
    local src = source
    if havePermission(src, Config.Permissions['clothing']) then
        if Config.Clothing == 'illenium_appearance' then
            TriggerEvent("illenium-appearance:client:openClothingShopMenu", player.id, true)
        elseif Config.Clothing == 'esx_skin' then
            TriggerEvent('esx_skin:openSaveableMenu', player.id)
        elseif Config.Clothing == 'custom' then
            --Insert Custom Trigger Here
        end
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)

RegisterNetEvent('dsAdminMenu:server:setPermissions', function(targetId, group)
    local src = source
    if havePermission(src, Config.Permissions['giveperms']) then
        local xTargetPlayer = ESX.GetPlayerFromId(targetId)
        local identifier = xTargetPlayer.getIdentifier()
        local result = MySQL.Sync.execute('UPDATE `users` SET `group` = @group WHERE `identifier` = @identifier', {
			['@group'] = group[1].rank,
			['@identifier'] = identifier})
        TriggerClientEvent('esx:showNotification', targetId, _U("rank_level",group[1].label))
    else
        DropPlayer(src, _U('info.banned', 'Exploiting'))
    end
end)


CreateThread(function()
    while true do
        local tempPlayers = {}
        local xPlayers = ESX.GetExtendedPlayers()
        for _, v in pairs(xPlayers) do
            local targetped = GetPlayerPed(v.source)
            tempPlayers[#tempPlayers + 1] = {
                name = (v.variables.firstName or '') .. ' ' .. (v.variables.lastName or '') .. ' | (' .. (GetPlayerName(v.source) or '') .. ')',
                id = v.source,
                coords = GetEntityCoords(targetped),
                cid =  v.variables.firstName .. ' ' .. v.variables.lastName,
                citizenid = v.identifier,
                sources = GetPlayerPed(v.source),
                sourceplayer = v.source

            }
        end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(tempPlayers, function(a, b)
            return a.id < b.id
        end)
        players = tempPlayers
        Wait(1500)
    end
end)

