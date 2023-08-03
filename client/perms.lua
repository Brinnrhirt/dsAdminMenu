--[[ 
    Hi, Here you can edit the amount of ranks you have in
    your server so you can give to the player
    Right now its:
    User, Mod and Admin, if you have more than this 3 ranks
    add it below
]]
function OpenPermsMenu(permsply)
    ESX.TriggerServerCallback('dsAdminMenu:server:getrank', function(rank)
        if rank then
            local selectedgroup = 'Unknown'
            MenuV:OpenMenu(menu11)
            menu11:ClearItems()
            menu11:AddSlider({
                icon = '',
                label = _U('menu.giveperms_group'),
                value = 'user',
                values = {values = {
                    label = 'User',
                    value = 'user'
                }, {
                    label = 'Mod',
                    value = 'mod'
                }, {
                    label = 'Admin',
                    value = 'admin'
                } -- Add a Comma if you're going to add another one
                --{
                    --label = 'Extra',
                    --value = 'extra'
                --},
                },
                change = function(_, newValue, _)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "user", label = "User"}
                    elseif vcal == 2 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "mod", label = "Mod"}
                    elseif vcal == 3 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "admin", label = "Admin"}
                    --elseif vcal == 4 then 
                        --selectedgroup = {}
                        --selectedgroup[#selectedgroup+1] = {rank = "extra", label = "Extra"}
                    end
                end
            })

            menu11:AddButton({
                icon = '',
                label = _U('info.confirm'),
                value = "giveperms",
                description = _U('desc.giveperms_desc'),
                select = function(_)
                    if selectedgroup ~= 'Unknown' then
                        TriggerServerEvent('dsAdminMenu:server:setPermissions', permsply.id, selectedgroup)
                        ESX.ShowNotification(_U('success.changed_perm'), 'success')
                        selectedgroup = 'Unknown'
                    else
                        ESX.ShowNotification(_U('error.changed_perm_failed'), 'error')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu1)
        end
    end)
end