Config = {}
Config.ESXOldVersion = false -- If you're using the old version (not legacy), remove the line 12 in the fxmanifest.lua
Config.Locale = 'es' -- en, es
Config.Discord = ''
Config.Inventory = 'ox_inventory' -- only ox_inventory or custom (change the code on the server side)
Config.Clothing = 'illenium_appearance' -- only illenium_appearnce, esx_skin or custom (change the code on the client side)
Config.ReviveTrigger = 'esx_ambulancejob' -- only esx_ambulancejob or custom
Config.Permissions = { -- change this as your server permissions
    -- To open the admin menu
    ['adminmenu'] = 'mod',

    -- Admin Commands
    ['kill'] = 'mod',
    ['maxmods'] = 'admin',
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
    ['kick'] = 'https://discord.com/api/webhooks/1117978450075062272/kioK2eFV1TMli2N_TxguIrexePB09JKswHFx_Gn57wQLiP4EClHeMjYt9QcyKp3h78os',
    ['bans'] = 'https://discord.com/api/webhooks/1117978450075062272/kioK2eFV1TMli2N_TxguIrexePB09JKswHFx_Gn57wQLiP4EClHeMjYt9QcyKp3h78os',
    ['revive'] = 'https://discord.com/api/webhooks/1117978450075062272/kioK2eFV1TMli2N_TxguIrexePB09JKswHFx_Gn57wQLiP4EClHeMjYt9QcyKp3h78os',
}