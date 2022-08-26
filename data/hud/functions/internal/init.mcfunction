# function bingo:init/setup_lobby was deleted, but bingo:init/setup_lobby_end needs to be called to set up forceloaded chunks
function bingo:init/setup_lobby_end


scoreboard objectives remove hud.conf
scoreboard objectives add hud.conf trigger
