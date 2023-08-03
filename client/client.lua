
ESX = exports['es_extended']:getSharedObject()

local banlength = nil
local developermode = false
local showCoords = false
local vehicleDevMode = false
local banreason = 'Unknown'
local kickreason = 'Unknown'
local menuLocation = 'topright' -- e.g. topright (default), topleft, bottomright, bottomleft
-- Main Menus
menu1 = MenuV:CreateMenu(false, _U("menu.admin_menu"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test1')
local menu2 = MenuV:CreateMenu(false, _U("menu.admin_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test2')
local menu3 = MenuV:CreateMenu(false, _U("menu.manage_server"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test3')
local menu4 = MenuV:CreateMenu(false, _U("menu.online_players"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test4')
local menu5 = MenuV:CreateMenu(false, _U("menu.vehicle_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test5')
local menu7 = MenuV:CreateMenu(false, _U("menu.developer_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test7')

--Sub Menus
local menu8 = MenuV:CreateMenu(false, _U("menu.weather_conditions"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test8')
local menu9 = MenuV:CreateMenu(false, _U("menu.ban"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test9')
local menu10 = MenuV:CreateMenu(false, _U("menu.kick"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test10')
menu11 = MenuV:CreateMenu(false, _U("menu.permissions"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test11')
local menu12 = MenuV:CreateMenu(false, _U("menu.vehicle_categories"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test12')
local menu13 = MenuV:CreateMenu(false, _U("menu.vehicle_models"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test13')
local menu14 = MenuV:CreateMenu(false, _U("menu.entity_view_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test14')
local menu15 = MenuV:CreateMenu(false, _U("menu.spawn_weapons"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test15')

RegisterNetEvent('dsAdminMenu:client:openMenu', function()
    MenuV:OpenMenu(menu1)
end)

--[[
    Main menu buttons
--]]
-- Admin options
menu1:AddButton({
    icon = '😃',
    label = _U("menu.admin_options"),
    value = menu2,
    description = _U("desc.admin_options_desc")
})

--player management
local player_management = menu1:AddButton({
    icon = '🙍‍♂️',
    label = _U("menu.player_management"),
    value = menu4,
    description = _U("desc.player_management_desc")
})

--server management
menu1:AddButton({
    icon = '🎮',
    label = _U("menu.server_management"),
    value = menu3,
    description = _U("desc.server_management_desc")
})

--vehicle spawner
menu1:AddButton({
    icon = '🚗',
    label = _U("menu.vehicles"),
    value = menu5,
    description = _U("desc.vehicles_desc")
})

--developer options
menu1:AddButton({
    icon = '🔧',
    label = _U("menu.developer_options"),
    value = menu7,
    description = _U("desc.developer_desc")
})

--[[
    Sub Menus for the above main menu's
--]]

-- Admin Options Menu Buttons
local menu2_admin_noclip = menu2:AddCheckbox({
    icon = '🎥',
    label = _U("menu.noclip"),
    value = nil,
    description = _U("desc.noclip_desc")
})

local menu2_admin_revive = menu2:AddButton({
    icon = '🏥',
    label = _U("menu.revive"),
    value = 'revive',
    description = _U("desc.revive_desc")
})

local menu2_admin_invisible = menu2:AddCheckbox({
    icon = '👻',
    label = _U("menu.invisible"),
    value = nil,
    description = _U("desc.invisible_desc")
})

local menu2_admin_god_mode = menu2:AddCheckbox({
    icon = '⚡',
    label = _U("menu.god"),
    value = nil,
    description = _U("desc.god_desc")
})

local menu2_admin_display_names = menu2:AddCheckbox({
    icon = '📋',
    label = _U("menu.names"),
    value = nil,
    description = _U("desc.names_desc")
})

local menu2_admin_display_blips = menu2:AddCheckbox({
    icon = '📍',
    label = _U("menu.blips"),
    value = nil,
    description = _U("desc.blips_desc")
})

--give weapons
menu2:AddButton({
    icon = '🎁',
    label = _U("menu.spawn_weapons"),
    value = menu15,
    description = _U("desc.spawn_weapons_desc")
})

-- Server Options Menu Buttons
local menu3_server_weather = menu3:AddButton({
    icon = '🌡️',
    label = _U("menu.weather_options"),
    value = menu8,
    description = _U("desc.weather_desc")
})

local menu3_server_time = menu3:AddSlider({
    icon = '⏲️',
    label = _U("menu.server_time"),
    value = GetClockHours(),
    values = {{
        label = '00',
        value = '00',
        description = _U("menu.time")
    }, {
        label = '01',
        value = '01',
        description = _U("menu.time")
    }, {
        label = '02',
        value = '02',
        description = _U("menu.time")
    }, {
        label = '03',
        value = '03',
        description = _U("menu.time")
    }, {
        label = '04',
        value = '04',
        description = _U("menu.time")
    }, {
        label = '05',
        value = '05',
        description = _U("menu.time")
    }, {
        label = '06',
        value = '06',
        description = _U("menu.time")
    }, {
        label = '07',
        value = '07',
        description = _U("menu.time")
    }, {
        label = '08',
        value = '08',
        description = _U("menu.time")
    }, {
        label = '09',
        value = '09',
        description = _U("menu.time")
    }, {
        label = '10',
        value = '10',
        description = _U("menu.time")
    }, {
        label = '11',
        value = '11',
        description = _U("menu.time")
    }, {
        label = '12',
        value = '12',
        description = _U("menu.time")
    }, {
        label = '13',
        value = '13',
        description = _U("menu.time")
    }, {
        label = '14',
        value = '14',
        description = _U("menu.time")
    }, {
        label = '15',
        value = '15',
        description = _U("menu.time")
    }, {
        label = '16',
        value = '16',
        description = _U("menu.time")
    }, {
        label = '17',
        value = '17',
        description = _U("menu.time")
    }, {
        label = '18',
        value = '18',
        description = _U("menu.time")
    }, {
        label = '19',
        value = '19',
        description = _U("menu.time")
    }, {
        label = '20',
        value = '20',
        description = _U("menu.time")
    }, {
        label = '21',
        value = '21',
        description = _U("menu.time")
    }, {
        label = '22',
        value = '22',
        description = _U("menu.time")
    }, {
        label = '23',
        value = '23',
        description = _U("menu.time")
    }}
})

-- Vehicle Spawner Menu Buttons
local menu5_vehicles_spawn = menu5:AddButton({
    icon = '🚗',
    label = _U("menu.spawn_vehicle"),
    value = menu12,
    description = _U("desc.spawn_vehicle_desc")
})

local menu5_vehicles_fix = menu5:AddButton({
    icon = '🔧',
    label = _U("menu.fix_vehicle"),
    value = 'fix',
    description = _U("desc.fix_vehicle_desc")
})

local menu5_vehicles_buy = menu5:AddButton({
    icon = '💲',
    label = _U("menu.buy"),
    value = 'buy',
    description = _U("desc.buy_desc")
})

local menu5_vehicles_remove = menu5:AddButton({
    icon = '🗑️',
    label = _U("menu.remove_vehicle"),
    value = 'remove',
    description = _U("desc.remove_vehicle_desc")
})

local menu5_vehicles_max_upgrades = menu5:AddButton({
    icon = '⚡️',
    label = _U("menu.max_mods"),
    value = 'maxmods',
    description = _U("desc.max_mod_desc")
})

-- Developer Options Menu Buttons
local menu7_dev_copy_vec3 = menu7:AddButton({
    icon = '📋',
    label = _U("menu.copy_vector3"),
    value = 'coords',
    description = _U("desc.vector3_desc")
})

local menu7_dev_copy_vec4 = menu7:AddButton({
    icon = '📋',
    label = _U("menu.copy_vector4"),
    value = 'coords',
    description = _U("desc.vector4_desc")
})

local menu7_dev_copy_heading = menu7:AddButton({
    icon = '📋',
    label = _U("menu.copy_heading"),
    value = 'heading',
    description = _U("desc.copy_heading_desc")
})

local menu7_dev_toggle_coords = menu7:AddCheckbox({
    icon = '📍',
    label = _U("menu.display_coords"),
    value = nil,
    description = _U("desc.display_coords_desc")
})

local menu7_dev_vehicle_mode = menu7:AddCheckbox({
    icon = '🚘',
    label = _U("menu.vehicle_dev_mode"),
    value = nil,
    description = _U("desc.vehicle_dev_mode_desc")
})


local menu7_dev_noclip = menu7:AddCheckbox({
    icon = '🎥',
    label = _U("menu.noclip"),
    value = nil,
    description = _U("desc.noclip_desc")
})

--create dev entity view
menu7:AddButton({
    icon = '🔍',
    label = _U("menu.entity_view_options"),
    value = menu14,
    description = _U("desc.entity_view_desc")
})


--[[
    General Functions
--]]
local function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0)
    Wait(0)
    end

    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return result
    end
end

local function LocalInputInt(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return tonumber(result)
    end
end

--[[
    Admin Options functions
--]]
-- Toggle player name display
menu2_admin_display_names:On('change', function()
    TriggerEvent('dsAdminMenu:client:toggleNames')
end)

-- Toggle player blip display
menu2_admin_display_blips:On('change', function()
    TriggerEvent('dsAdminMenu:client:toggleBlips')
end)

-- Toggle NoClip
menu2_admin_noclip:On('change', function(_, _, _)
    ToggleNoClip()
end)

-- Revive Self
menu2_admin_revive:On('select', function(_)
    TriggerEvent('dsAdminMenu:client:revive', PlayerPedId())
end)

-- Invisible
local invisible = false
menu2_admin_invisible:On('change', function(_, _, _)
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)

-- Godmode
local godmode = false
menu2_admin_god_mode:On('change', function(_, _, _)
    godmode = not godmode

    if godmode then
        while godmode do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

-- Weapons list
local Weapons = ESX.GetWeaponList()
for i=1, #Weapons, 1 do
    menu15:AddButton({icon = '🎁',
        label = Weapons[i].label ,
        value = Weapons[i].name ,
        description = _U("desc.spawn_weapons_desc"),
        select = function(_)
            TriggerServerEvent('dsAdminMenu:giveWeapon', Weapons[i].name)
            ESX.ShowNotification(_U("success.spawn_weapon"))
        end
    })
end



local function OpenKickMenu(kickplayer)
    MenuV:OpenMenu(menu10)
    menu10:ClearItems()
    menu10:AddButton({
        icon = '',
        label = _U("info.reason"),
        value = "reason",
        description = _U("desc.kick_reason"),
        select = function(_)
            kickreason = LocalInput(_U("desc.kick_reason"), 255)
        end
    })

    menu10:AddButton({
        icon = '',
        label = _U("info.confirm"),
        value = "kick",
        description = _U("desc.confirm_kick"),
        select = function(_)
            if kickreason ~= 'Unknown' then
                TriggerServerEvent('dsAdminMenu:server:kick', kickplayer, kickreason)
                kickreason = 'Unknown'
            else
                ESX.ShowNotification(_U("error.missing_reason"), 'error')
            end
        end
    })
end

local function OpenBanMenu(banplayer)
    MenuV:OpenMenu(menu9)
    menu9:ClearItems()
    menu9:AddButton({
        icon = '',
        label = _U("info.reason"),
        value = "reason",
        description = _U("desc.ban_reason"),
        select = function(_)
            banreason = LocalInput(_U("desc.ban_reason"), 255)
        end
    })

    menu9:AddSlider({
        icon = '⏲️',
        label = _U("info.length"),
        value = '3600',
        values = {{
            label = _U("time.1hour"),
            value = '3600',
            description = _U("time.ban_length")
        }, {
            label = _U("time.6hour"),
            value ='21600',
            description = _U("time.ban_length")
        }, {
            label = _U("time.12hour"),
            value = '43200',
            description = _U("time.ban_length")
        }, {
            label = _U("time.1day"),
            value = '86400',
            description = _U("time.ban_length")
        }, {
            label = _U("time.3day"),
            value = '259200',
            description = _U("time.ban_length")
        }, {
            label = _U("time.1week"),
            value = '604800',
            description = _U("time.ban_length")
        }, {
            label = _U("time.1month"),
            value = '2678400',
            description = _U("time.ban_length")
        }, {
            label = _U("time.3month"),
            value = '8035200',
            description = _U("time.ban_length")
        }, {
            label = _U("time.6month"),
            value = '16070400',
            description = _U("time.ban_length")
        }, {
            label = _U("time.1year"),
            value = '32140800',
            description = _U("time.ban_length")
        }, {
            label = _U("time.permenent"),
            value = '99999999999',
            description = _U("time.ban_length")
        }, {
            label = _U("time.self"),
            value = "self",
            description = _U("time.ban_length")
        }},
        select = function(_, newValue, _)
            if newValue == "self" then
                banlength = LocalInputInt('Ban Length', 11)
            else
                banlength = newValue
            end
        end
    })

    menu9:AddButton({
        icon = '',
        label = _U("info.confirm"),
        value = "ban",
        description = _U("desc.confirm_ban"),
        select = function(_)
            if banreason ~= 'Unknown' and banlength ~= nil then
                TriggerServerEvent('dsAdminMenu:server:ban', banplayer, banlength, banreason)
                banreason = 'Unknown'
                banlength = nil
            else
                ESX.ShowNotification(_U("error.invalid_reason_length_ban"), 'error')
            end
        end
    })
end

local function OpenPlayerMenus(player)
    local Players = MenuV:CreateMenu(false, player.cid .. _U("info.options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)
    local elements = {
        [1] = {
            icon = '💀',
            label = _U("menu.kill"),
            value = "kill",
            description = _U("menu.kill").. " " .. player.cid
        },
        [2] = {
            icon = '🏥',
            label = _U("menu.revive"),
            value = "revive",
            description = _U("menu.revive") .. " " .. player.cid
        },
        [3] = {
            icon = '🥶',
            label = _U("menu.freeze"),
            value = "freeze",
            description = _U("menu.freeze") .. " " .. player.cid
        },
        [4] = {
            icon = '👀',
            label = _U("menu.spectate"),
            value = "spectate",
            description = _U("menu.spectate") .. " " .. player.cid
        },
        [5] = {
            icon = '➡️',
            label = _U("info.goto"),
            value = "goto",
            description = _U("info.goto") .. " " .. player.cid .. _U("info.position")
        },
        [6] = {
            icon = '⬅️',
            label = _U("menu.bring"),
            value = "bring",
            description = _U("menu.bring") .. " " .. player.cid .. " " .. _U("info.your_position")
        },
        [7] = {
            icon = '🚗',
            label = _U("menu.sit_in_vehicle"),
            value = "intovehicle",
            description = _U("desc.sit_in_veh_desc") .. " " .. player.cid .. " " .. _U("desc.sit_in_veh_desc2")
        },
        [8] = {
            icon = '🎒',
            label = _U("menu.open_inv"),
            value = "inventory",
            description = _U("info.open") .. " " .. player.cid .. _U("info.inventories")
        },
        [9] = {
            icon = '👕',
            label = _U("menu.give_clothing_menu"),
            value = "cloth",
            description = _U("desc.clothing_menu_desc") .. " " .. player.cid
        },
        [10] = {
            icon = '🥾',
            label = _U("menu.kick"),
            value = "kick",
            description = _U("menu.kick") .. " " .. player.cid .. " " .. _U("info.reason")
        },
        [11] = {
            icon = '🚫',
            label = _U("menu.ban"),
            value = "ban",
            description = _U("menu.ban") .. " " .. player.cid .. " " .. _U("info.reason")
        },
        [12] = {
            icon = '🎟️',
            label = _U("menu.permissions"),
            value = "perms",
            description = _U("info.give") .. " " .. player.cid .. " " .. _U("menu.permissions")
        }
    }
    for _, v in ipairs(elements) do
        Players:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values ~= "ban" and values ~= "kick" and values ~= "perms" then
                    TriggerServerEvent('dsAdminMenu:server:'..values, player)
                elseif values == "ban" then
                    OpenBanMenu(player)
                elseif values == "kick" then
                    OpenKickMenu(player)
                elseif values == "perms" then
                    OpenPermsMenu(player)
                end
            end
        })
    end
end

player_management:On('select', function(_)
    menu4:ClearItems()
    ESX.TriggerServerCallback('test:getplayers', function(players)
        for _, v in pairs(players) do
            menu4:AddButton({
                label = _U("info.id") .. v["id"] .. ' | ' .. v["name"],
                value = v,
                description = _U("info.player_name"),
                select = function(btn)
                    local select = btn.Value -- get all the values from v!
                    OpenPlayerMenus(select) -- only pass what i select nothing else
                end
            }) -- WORKS
        end
    end)
end)


--[[
    Server Options functions
--]]

-- Adjust weather on change
menu3_server_weather:On("select",function()
    menu8:ClearItems()
    local elements = {
        [1] = {
            icon = '☀️',
            label = _U("weather.extra_sunny"),
            value = "EXTRASUNNY",
            description = _U("weather.extra_sunny_desc")
        },
        [2] = {
            icon = '☀️',
            label = _U("weather.clear"),
            value = "CLEAR",
            description = _U("weather.clear_desc")
        },
        [3] = {
            icon = '☀️',
            label = _U("weather.neutral"),
            value = "NEUTRAL",
            description = _U("weather.neutral_desc")
        },
        [4] = {
            icon = '🌁',
            label = _U("weather.smog"),
            value = "SMOG",
            description = _U("weather.smog_desc")
        },
        [5] = {
            icon = '🌫️',
            label = _U("weather.foggy"),
            value = "FOGGY",
            description = _U("weather.foggy_desc")
        },
        [6] = {
            icon = '⛅',
            label = _U("weather.overcast"),
            value = "OVERCAST",
            description = _U("weather.overcast_desc")
        },
        [7] = {
            icon = '☁️',
            label = _U("weather.clouds"),
            value = "CLOUDS",
            description = _U("weather.clouds_desc")
        },
        [8] = {
            icon = '🌤️',
            label = _U("weather.clearing"),
            value = "CLEARING",
            description = _U("weather.clearing_desc")
        },
        [9] = {
            icon = '☂️',
            label = _U("weather.rain"),
            value = "RAIN",
            description = _U("weather.rain_desc")
        },

        [10] = {
            icon = '⛈️',
            label = _U("weather.thunder"),
            value = "THUNDER",
            description = _U("weather.thunder_desc")
        },
        [11] = {
            icon = '❄️',
            label = _U("weather.snow"),
            value = "SNOW",
            description = _U("weather.snow_desc")
        },
        [12] = {
            icon = '🌨️',
            label = _U("weather.blizzard"),
            value = "BLIZZARD",
            description = _U("weather.blizzed_desc")
        },
        [13] = {
            icon = '❄️',
            label = _U("weather.light_snow"),
            value = "SNOWLIGHT",
            description = _U("weather.light_snow_desc")
        },
        [14] = {
            icon = '🌨️',
            label = _U("weather.heavy_snow"),
            value = "XMAS",
            description = _U("weather.heavy_snow_desc")
        },
        [15] = {
            icon = '🎃',
            label = _U("weather.halloween"),
            value = "HALLOWEEN",
            description = _U("weather.halloween_desc")
        }
    }
    for _, v in ipairs(elements) do
        menu8:AddButton({icon = v.icon,label = v.label,value = v,description = v.description,select = function(btn)
            local selection = btn.Value
            TriggerServerEvent('qb-weathersync:server:setWeather', selection.value)
            ESX.ShowNotification(_U("weather.weather_changed", {value = selection.label}))
        end})
    end
end)

-- Adjust time on change
menu3_server_time:On("select", function(_, value)
    TriggerServerEvent("qb-weathersync:server:setTime", value, value)
    ESX.ShowNotification(_U("time.changed", {time = value}))
end)

--[[
    Vehicle Spawner functions
--]]

-- Set vehicle Categories
local vehicles = {}

for k, v in pairs(VehiclesList) do
    local category = v["category"]
    if vehicles[category] == nil then
        vehicles[category] = { }
    end
    vehicles[category][k] = v
end

-- Car Categories
local function OpenCarModelsMenu(category)
    menu13:ClearItems()
    MenuV:OpenMenu(menu13)
    for k, v in pairs(category) do
        menu13:AddButton({
            label = v["name"],
            value = k,
            description = 'Spawn ' .. v["name"],
            select = function(_)
                ExecuteCommand("car " ..k)
            end
        })
    end
end

menu5_vehicles_spawn:On('Select', function(_)
    menu12:ClearItems()
    for k, v in pairs(vehicles) do
        menu12:AddButton({
            label = FirstToUpper(k),
            value = v,
            description = _U("menu.category_name"),
            select = function(btn)
                local select = btn.Value
                OpenCarModelsMenu(select)
            end
        })
    end
end)

menu5_vehicles_fix:On('Select', function(_)
    ExecuteCommand("fix")
end)

menu5_vehicles_buy:On('Select', function(_)
    ExecuteCommand("admincar")
end)

menu5_vehicles_remove:On('Select', function(_)
    ExecuteCommand("dv")
end)

menu5_vehicles_max_upgrades:On('Select', function(_)
    ExecuteCommand("maxmods")
end)

--[[
    Developer Options functions
--]]
local entity_view_distance = menu14:AddSlider({
    icon = '📏',
    label = _U("menu.entity_view_distance"),
    value = GetCurrentEntityViewDistance(),
    values = {{
        label = '5',
        value = '5',
        description = _U("menu.entity_view_distance")
    }, {
        label = '10',
        value = '10',
        description = _U("menu.entity_view_distance")
    }, {
        label = '15',
        value = '15',
        description = _U("menu.entity_view_distance")
    }, {
        label = '20',
        value = '20',
        description = _U("menu.entity_view_distance")
    }, {
        label = '25',
        value = '25',
        description = _U("menu.entity_view_distance")
    }, {
        label = '30',
        value = '30',
        description = _U("menu.entity_view_distance")
    }, {
        label = '35',
        value = '35',
        description = _U("menu.entity_view_distance")
    }, {
        label = '40',
        value = '40',
        description = _U("menu.entity_view_distance")
    }, {
        label = '45',
        value = '45',
        description = _U("menu.entity_view_distance")
    }, {
        label = '50',
        value = '50',
        description = _U("menu.entity_view_distance")
    }}
})

local entity_view_copy_info = menu14:AddButton({
    icon = '📋',
    label = _U("menu.entity_view_freeaim_copy"),
    value = 'freeaimEntity',
    description = _U("desc.entity_view_freeaim_copy_desc")
})

local entity_view_freeaim = menu14:AddCheckbox({
    icon = '🔫',
    label = _U("menu.entity_view_freeaim"),
    value = nil,
    description = _U("desc.entity_view_freeaim_desc")
})

local entity_view_vehicle = menu14:AddCheckbox({
    icon = '🚗',
    label = _U("menu.entity_view_vehicles"),
    value = nil,
    description = _U("desc.entity_view_vehicles_desc")
})

local entity_view_ped = menu14:AddCheckbox({
    icon = '🧍‍♂‍',
    label = _U("menu.entity_view_peds"),
    value = nil,
    description = _U("desc.entity_view_peds_desc")
})

local entity_view_object = menu14:AddCheckbox({
    icon = '📦',
    label = _U("menu.entity_view_objects"),
    value = nil,
    description = _U("desc.entity_view_objects_desc")
})

entity_view_freeaim:On('change', function(_, _, _)
    ToggleEntityFreeView()
end)

local function CopyToClipboard(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords2' then
        local coords = GetEntityCoords(ped)
        local x = ESX.Math.Round(coords.x, 2)
        local y = ESX.Math.Round(coords.y, 2)
        SendNUIMessage({
            string = string.format('vector2(%s, %s)', x, y)
        })
        ESX.ShowNotification(_U("success.coords_copied"), "success")
    elseif dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = ESX.Math.Round(coords.x, 2)
        local y = ESX.Math.Round(coords.y, 2)
        local z = ESX.Math.Round(coords.z, 2)
        SendNUIMessage({
            string = string.format('vector3(%s, %s, %s)', x, y, z)
        })
        ESX.ShowNotification(_U("success.coords_copied"), "success")
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = ESX.Math.Round(coords.x, 2)
        local y = ESX.Math.Round(coords.y, 2)
        local z = ESX.Math.Round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = ESX.Math.Round(heading, 2)
        SendNUIMessage({
            string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        })
        ESX.ShowNotification(_U("success.coords_copied"), "success")
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = ESX.Math.Round(heading, 2)
        SendNUIMessage({
            string = h
        })
        ESX.ShowNotification(_U("success.heading_copied"), "success")
    elseif dataType == 'freeaimEntity' then
        local entity = GetFreeAimEntity()

        if entity then
            local entityHash = GetEntityModel(entity)
            local entityName = Entities[entityHash] or "Unknown"
            local entityCoords = GetEntityCoords(entity)
            local entityHeading = GetEntityHeading(entity)
            local entityRotation = GetEntityRotation(entity)
            local x = ESX.Math.Round(entityCoords.x, 2)
            local y = ESX.Math.Round(entityCoords.y, 2)
            local z = ESX.Math.Round(entityCoords.z, 2)
            local rotX = ESX.Math.Round(entityRotation.x, 2)
            local rotY = ESX.Math.Round(entityRotation.y, 2)
            local rotZ = ESX.Math.Round(entityRotation.z, 2)
            local h = ESX.Math.Round(entityHeading, 2)
            SendNUIMessage({
                string = string.format('Model Name:\t%s\nModel Hash:\t%s\n\nHeading:\t%s\nCoords:\t\tvector3(%s, %s, %s)\nRotation:\tvector3(%s, %s, %s)', entityName, entityHash, h, x, y, z, rotX, rotY, rotZ)
            })
            ESX.ShowNotification(_U("success.entity_copy"), "success")
        else
            ESX.ShowNotification(_U("error.failed_entity_copy"), "error")
        end
    end
end

RegisterNetEvent('dsAdminMenu:client:copyToClipboard', function(dataType)
    CopyToClipboard(dataType)
end)

local function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end

local function ToggleShowCoordinates()
    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = ESX.Math.Round(coords.x, 2)
            c.y = ESX.Math.Round(coords.y, 2)
            c.z = ESX.Math.Round(coords.z, 2)
            heading = ESX.Math.Round(heading, 2)
            Wait(0)
            Draw2DText(string.format('~w~'.._U("info.ped_coords") .. '~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end

local function ToggleVehicleDeveloperMode()
    local x = 0.4
    local y = 0.888
    vehicleDevMode = not vehicleDevMode
    CreateThread(function()
        while vehicleDevMode do
            local ped = PlayerPedId()
            Wait(0)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local netID = VehToNet(vehicle)
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local eHealth = GetVehicleEngineHealth(vehicle)
                local bHealth = GetVehicleBodyHealth(vehicle)
                Draw2DText(_U("info.vehicle_dev_data"), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
                Draw2DText(string.format(_U("info.ent_id") .. '~b~%s~s~ | ' .. _U("info.net_id") .. '~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.025)
                Draw2DText(string.format(_U("info.model") .. '~b~%s~s~ | ' .. _U("info.hash") .. '~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.050)
                Draw2DText(string.format(_U("info.eng_health") .. '~b~%s~s~ | ' .. _U("info.body_health") .. '~b~%s~s~', ESX.Math.Round(eHealth, 2), ESX.Math.Round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.075)
            end
        end
    end)
end

RegisterNetEvent('dsAdminMenu:client:ToggleCoords', function()
    ToggleShowCoordinates()
end)

menu7_dev_copy_vec3:On("select", function()
    CopyToClipboard('coords3')
end)

menu7_dev_copy_vec4:On("select", function()
    CopyToClipboard('coords4')
end)

menu7_dev_copy_heading:On("select", function()
    CopyToClipboard('heading')
end)

entity_view_copy_info:On("select", function()
    CopyToClipboard('freeaimEntity')
end)

menu7_dev_vehicle_mode:On('change', function()
    ToggleVehicleDeveloperMode()
end)

menu7_dev_noclip:On('change', function(_, _, _)
    ToggleNoClip()
end)

menu7_dev_toggle_coords:On('change', function()
    ToggleShowCoordinates()
end)

entity_view_distance:On("select", function(_, value)
    SetEntityViewDistance(value)
    ESX.ShowNotification(_U("info.entity_view_distance", {distance = value}))
end)

entity_view_vehicle:On('change', function()
    ToggleEntityVehicleView()
end)

entity_view_object:On('change', function()
    ToggleEntityObjectView()
end)

entity_view_ped:On('change', function()
    ToggleEntityPedView()
end)


function FirstToUpper(value)
    if not value then return nil end
    return (value:gsub("^%l", string.upper))
end