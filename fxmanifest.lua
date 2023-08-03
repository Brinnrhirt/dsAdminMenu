fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Brinnrhirt'
description 'QBCore Admin Menu for ESX'
version '1.1.3'

ui_page 'html/index.html'


shared_scripts {
    '@es_extended/imports.lua', -- Only for Legacy ESX, remove if you're not using it
    'config/config.lua',
    'config/locale.lua',
    'config/vehicles.lua',
    'locales/*.lua',
}

client_scripts {
    '@menuv/menuv.lua',
    'config/config.lua',
    'client/noclip.lua',
    'client/entity_view.lua',
    'client/blipsnames.lua',
    'client/perms.lua',
    'client/client.lua',
    'client/events.lua',
    'entityhashes/entity.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/config.lua',
    'server/functions.lua',
    'server/logs.lua',
    'server/server.lua',
    'server/commands.lua'
}

files { -- Credits to https://github.com/LVRP-BEN/bl_coords for clipboard copy method
    'html/index.html',
    'html/index.js'
}

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'client/*/lua',
    'server/*.lua',
    'entityhashes/*.lua',
    'locales/*.lua'
}

dependency {
    'es_extended',
    'menuv'
}

