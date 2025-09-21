RegisterServerEvent('lc_fishing:giveReward')
AddEventHandler('lc_fishing:giveReward', function()
    local src = source
    if Config.UsingOxLib then
        if exports.ox_inventory:CanCarryItem(src, Config.RewardItem, 1) then
            exports.ox_inventory:AddItem(src, Config.RewardItem, 1)
        else
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Fishing',
                description = 'You cannot carry any more fish!',
                type = 'error',
                duration = 5000,
                position = 'bottom'
            })
        end
    else
        Config.RewardFunction()
    end
end)