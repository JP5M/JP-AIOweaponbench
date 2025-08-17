fx_version 'cerulean'
game 'gta5'
author 'JP5M Scripts'
version '1.0.2'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared.lua'
}

server_scripts {
    'server.lua'
}

client_scripts {
    'client.lua'
}

dependencies {
    'ox_inventory',
    'ox_lib',
    'ox_target'
}

escrow_ignore {
    '*.lua'
}