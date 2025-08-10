fx_version 'cerulean'
game 'gta5'

description 'Custom HUD for ESX/QBCore Framework'
author 'Pitrs'
version '1.0.0'

lua54 'yes'

ui_page 'html/index.html'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

data_file 'SCALEFORM_DLL' 'stream/minimap.gfx'
files {
    'stream/minimap.gfx',
    'stream/squaremap.ytd'
}

despencies {
    'ox_lib',
    'oxmysql',
    'es_extended',
    'esx_status',
    'esx_basicneeds',
}