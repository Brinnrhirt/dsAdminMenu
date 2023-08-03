
function havePermission(src, permission)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
    if IsPlayerAceAllowed(src, permission) then
        return true
    elseif IsPlayerAceAllowed(src, 'command') then
        return true
    else
        return false
    end
end
function GetIdentifiers(source, idtype)
    local idtype = idtype
    for key, value in pairs(GetPlayerIdentifiers(source)) do
        if string.find(value, idtype) then
            print(value)
            return value
        end
    end
    return nil
end

function IsPlayerBanned(source)
    local plicense = GetIdentifiers(source, 'license')
    local result = MySQL.Sync.fetchSingle('SELECT * FROM bans WHERE license = ?', { plicense })
    if not result then return false end
    if os.time() < result.expire then
        local timeTable = os.date('*t', tonumber(result.expire))
        return true, _U('info.banned',result.reason)  .. '\n'.._U('info.ban_expires') .. timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n'
    else
        MySQL.Async.execute('DELETE FROM bans WHERE id = ?', { result.id })
    end
    return false
end

function IsLicenseInUse(license)
    local players = GetPlayers()
    for key, value in pairs(players) do
        local identifiers = GetPlayerIdentifiers(value)
        for _, id in pairs(identifiers) do
            if string.find(id, 'license') then
                if id == license then
                    return true
                end
            end
        end
    end
    return false
end

function BanPlayer(src)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(src),
        GetIdentifiers(src, 'license'),
        GetIdentifiers(src, 'discord'),
        GetIdentifiers(src, 'ip'),
        "Trying to revive theirselves or other players",
        2147483647,
        'dsAdminMenu'
    })
    if Config.EnableWebhooks then
        TriggerEvent('dsAdminMenu:server:CreateLog', 'adminmenu', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(src), 'dsAdminMenumenu', "Trying to trigger admin options which they dont have permission for"), true)
    end
    DropPlayer(src, 'You were permanently banned by the server for: Exploiting')
end