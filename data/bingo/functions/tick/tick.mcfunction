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

# Auto-validate if Singleplayer
execute if score $is_multiplayer bingo.state matches 0 run tellraw @a[tag=bingo.resourcepack_check] "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
execute if score $is_multiplayer bingo.state matches 0 run scoreboard players set @a[tag=bingo.resourcepack_check] bingo.resources 91

# Send Resource pack check chat message
#
# Uses technical translation strings with unused argument indexes - below
# (1, 2 are string argument indexes used in IF: [translated ? <2> : <1>])
#
# For easier understanding: <val/string> - value/encoded-string* as "%<val>$s"
# e.g. 'bingo' encoded* as 1074992263 => "%1074992263$s"; 1 => "%1$s"
# - "<bingo><1>" - bingo resource pack
# - "<bingo><X><1>" - RP-version equal check: <X>[version iteration, 3+]
# - "<bingo><3><X><1>" - RP-version equal or above check: <X>[as above]
# All above translate to "<2>"="%2$s" (2nd argument), in [en_us] lang-file
# 
# *NeunEinser's encoder: https://github.com/NeunEinser/translation-placeholder-namespace

#NEUN_SCRIPT uncomment
#tellraw @a[scores={bingo.resources=1}] [{"translate": "%1074992263$s%1$s", "with": [["", {"text": "The resourcepack is currently not enabled.", "color": "red"}, "\nIf there is a server resource pack in place, enable it and wait until the Mojang loading screen is done. Then click “re-check” down below.\n\nOtherwise, please download the resource pack ", {"text": "here", "color": "#00c3ff", "clickEvent": {"action": "open_url", "value": "https://github.com/NeunEinser/bingo/releases/tag/5.0"}}, " and enable it.\n\n[", {"text": "Re-check", "color": "#00c3ff", "clickEvent": {"action": "run_command", "value": "/trigger bingo.resources"}}, "]"], ["", {"translate": "%1074992263$s%{NEUN_SCRIPT:rp_version}$s%1$s", "with": [["", {"translate": "%1074992263$s%3$s%3$s%1$s", "with": [["", {"text": "Incorrect resource pack version enabled.", "color": "red"}, "\nYou are using an incompatible version of the Fetchr resource pack.\n\nPlease download the correct version ", {"text": "here", "color": "#00c3ff", "clickEvent": {"action": "open_url", "value": "https://github.com/NeunEinser/bingo/releases/tag/5.0"}}, ", enable it and click “re-check” down below.\n\nIf the resource pack was applied automatically through a server resource pack, please inform the server admin to update the server resource pack.\n\n[", {"text": "Re-check", "color": "#00c3ff", "clickEvent": {"action": "run_command", "value": "/trigger bingo.resources"}}, "]"], ["", {"translate": "bingo.resourcepack_check.wrong_version.title", "color": "red"}, "\n", {"translate": "bingo.resourcepack_check.wrong_version.description", "with": [{"translate": "bingo.resourcepack_check.wrong_version.link", "color": "#00c3ff", "clickEvent": {"action": "open_url", "value": "https://github.com/NeunEinser/bingo/releases/tag/5.0"}}]}, "\n\n", {"translate": "bingo.resourcepack_check.wrong_version.server"}, "\n\n[", {"translate": "bingo.resourcepack_check.wrong_version.recheck", "color": "#00c3ff", "clickEvent": {"action": "run_command", "value": "/trigger bingo.resources"}}, "]"]]}], ["", {"translate": "bingo.resourcepack_check.go_to_lobby.part1", "color": "green"}]]}]]}]

#NEUN_SCRIPT remove
tellraw @a[scores={bingo.resources=1}] [{"translate": "%1074992263$s%1$s", "with": [["",{"text": "The resourcepack is currently not enabled.", "color": "red"}, "\nThis is not a release version, thus no resource pack download can be provided. You can get the resource pack from master as well, just like you did with the data pack. You will need to download and apply the NegativeSpaceFont linked in readme manually as well, though.\n\nIf you want to play the release version, please follow the instructions on ", {"text": "this page", "color": "#00c3ff", "clickEvent": {"action": "open_url", "value": "https://github.com/NeunEinser/bingo/releases"}}, "."], ["", {"translate": "bingo.resourcepack_check.go_to_lobby.part1", "color": "green"}]]}]

# Validate checked players, reenable trigger
scoreboard players enable @a[tag=bingo.resourcepack_check] bingo.resources
scoreboard players set @a[scores={bingo.resources=1}] bingo.resources 0
tag @a[scores={bingo.resources=91}] remove bingo.resourcepack_check

#endregion

# Assign each player a unique ID
execute as @a[scores={bingo.reconnect=1}] run function #bingo:player_reconnect
execute as @a unless score @s bingo.id matches -2147483648.. run function #bingo:new_player

# custom hud
data modify storage tmp.bingo:custom_hud handled set value []
execute as @a run function bingo:custom_hud/tick
data modify storage bingo:custom_hud players append from storage tmp.bingo:custom_hud handled[]

# Loop depending on game state
function bingo:lobby/tick

scoreboard players operation $last_tick bingo.state = $raw 91.timer.time