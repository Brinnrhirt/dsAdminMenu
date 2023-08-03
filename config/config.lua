Config = {}
Config.ESXOldVersion = false -- If you're using the old version (not legacy), remove the line 12 in the fxmanifest.lua
Config.Locale = 'en' -- en, es
Config.Discord = '' -- For banned
Config.Inventory = 'ox_inventory' -- only ox_inventory or custom (change the code on the server side)
Config.Clothing = 'illenium_appearance' -- only illenium_appearnce, esx_skin or custom (change the code on the client side)
Config.ReviveTrigger = 'esx_ambulancejob' -- only esx_ambulancejob or custom
Config.ActivateWeatherMenu = true -- Only works for vSync if you're using other weather script its better if you use the corresponding menu
Config.MenuLocation = 'topright' -- e.g. topright (default), topleft, bottomright, bottomleft
Config.Permissions = { -- change this as your server permissions
    -- To open the admin menu
    ['adminmenu'] = 'mod',

    -- Admin Commands
    ['kill'] = 'mod',
    ['maxmods'] = 'admin',
    ['fix'] = 'mod',
    ['setspeed'] = 'admin',
    ['ban'] = 'admin',
    ['noclip'] = 'mod',
    ['kickall'] = 'admin',
    ['kick'] = 'mod',
    ["revive"] = "mod",
    ["freeze"] = "mod",
    ["goto"] = "mod",
    ["spectate"] = "mod",
    ["intovehicle"] = "mod",
    ["bring"] = "mod",
    ["inventory"] = "admin",
    ["clothing"] = "mod",
    ["giveperms"] = "admin",
    ["staffchat"] = "mod",

    -- Development
    ['vector2'] = 'mod',
    ['vector3'] = 'mod',
    ['vector4'] = 'mod',
    ['heading'] = 'mod',
    ['blips'] = 'admin',
    ['names'] = 'admin',
    ['coords'] = 'admin'
}

Config.EnableWebhooks = true

Config.Webhook = { -- Only works if Config.EnableWebhooks its enabled
    ['kick'] = '',
    ['bans'] = '',
    ['revive'] = '',
}