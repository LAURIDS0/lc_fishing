fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'LC Development'
description 'Browser usb handler for lc_tablet.'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua', -- For ox_lib functions and testing only
    'config.lua'
}

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua'
}