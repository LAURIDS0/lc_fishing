Config = {}

Config.UsingOxLib = true -- Set to false if you are not using ox_lib

Config.FishingTimeInSeconds = {
    min = 5,
    max = 10
}

-- If using ox_lib and ox_inventory, set the item you want to give as a reward here
Config.RewardItem = 'cod_fish'
-- If not using ox_lib, you can add your own code and enter the export here:
Config.RewardFunction = ''
