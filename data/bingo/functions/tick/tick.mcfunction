#> bingo:tick/tick
#
# This function is called every tick
#
# This contains some base logic, but most of the stuff happens in
# bingo:lobby/tick and bingo:game/tick
#
# @within tag/function minecraft:tick
# @handles #minecraft:tick

function neun_einser.timer:store_current_time

#region Resource pack check
# Detect second (or more) players in a LAN world
execute store result score $is_multiplayer bingo.state if entity @a
scoreboard players remove $is_multiplayer bingo.state 1
execute if score $is_multiplayer bingo.state matches 2.. run scoreboard players set $is_multiplayer bingo.state 1

# Detect the resource pack not being active server-side (So either we are on a
# server, or resourcepack is missing in single player for some reason)
#
# Uses name-check from technical translation:
# - "bingo.technical.detect_multiplayer" -> "DoNotTranslateThis<X>"
#    <X> being version-check iteration (3+) (also used below)
execute if score $is_multiplayer bingo.state matches 0 unless entity @e[name="DoNotTranslateThis{NEUN_SCRIPT:rp_version}", limit=1] run scoreboard players set $is_multiplayer bingo.state 1
#endregion

# player tick
data modify storage tmp.bingo:custom_hud handled set value []
execute as @a run function bingo:tick/player_tick
data modify storage bingo:custom_hud players append from storage tmp.bingo:custom_hud handled[]

scoreboard players operation $last_tick bingo.state = $raw 91.timer.time


############################# KEEP AT END OF FILE #############################
# Loop depending on game state
function bingo:lobby/tick

scoreboard players operation $last_tick bingo.state = $raw 91.timer.time