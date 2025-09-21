-- TODO: 
    -- Add if player is looking at water
    -- Add if player is in a boat
    -- 1. Add fishing mini-game

local function fishingNotify(description, infoType, duration)
    local iconColor = 'orange'
    if infoType == 'error' then iconColor = 'red'
    elseif infoType == 'success' then iconColor = 'green'
    else iconColor = 'orange'
    end
    if Config.UsingOxLib then
        lib.notify({
            title = 'Fishing', description = description, position = 'bottom', duration = duration or 5000, iconColor = iconColor or 'orange', type = infoType
        })
    else
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(description)
        EndTextCommandThefeedPostTicker(false, false)
    end
end


local function startFishing()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, true)
    local fishingTime = math.random(Config.FishingTimeInSeconds.min, Config.FishingTimeInSeconds.max) * 1000
    fishingNotify('Countdown to catch a fish!', 'success', fishingTime)
    Citizen.Wait(fishingTime)
    if Config.UsingOxLib then
        local success = lib.skillCheck({'easy', 'easy', 'easy'}, {'e'})
        if success then
            ClearPedTasks(PlayerPedId())
            fishingNotify('You caught a fish!', 'success', 2000)
            TriggerServerEvent('lc_fishing:giveReward')
        else
            ClearPedTasks(PlayerPedId())
            fishingNotify('The fish got away!', 'error', 2000)
        end
    else
        -- 1. Line 3
        ClearPedTasks(PlayerPedId())
        fishingNotify('You caught a fish!', 'success', 2000)
        Config.RewardFunction()
    end
end

local function isPlayerNearWater()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local waterHeight = 0.0
    local isInWater = GetWaterHeight(playerCoords.x, playerCoords.y, playerCoords.z, waterHeight)
    return isInWater
end

local function triggerFishing()
    if isPlayerNearWater() then
        startFishing()
    else
        fishingNotify('You need to be near water to fish!', 'error', 2000)
    end
end

RegisterCommand('fish', function()
    triggerFishing()
end, false)

exports('startFishing', triggerFishing)