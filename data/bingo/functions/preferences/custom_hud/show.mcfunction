#> bingo:preferences/custom_hud/show
#
# Shows the currently selected custom hud menu page
#
# @within
# 	function bingo:preferences/show
# 	function bingo:preferences/custom_hud/**
# @context entity Player who triggered bingo.pref
# @reads
# 	storage bingo:custom_hud players
# 	storage bingo:registries preferences.custom_hud
# @writes torage bingo:custom_hud currentPlayer

#>
# @within function bingo:preferences/custom_hud/**
#declare storage tmp.bingo:preferences/hud

data modify storage tmp.bingo:preferences/hud skippedHuds set value []
function bingo:preferences/custom_hud/find_player
data modify storage bingo:custom_hud currentPlayer set from storage tmp.bingo:preferences/hud skippedHuds[0]
data remove storage tmp.bingo:preferences/hud skippedHuds[0]

execute if score @s bingo.pref matches 5 run data modify storage io.bingo:preferences menuOptions set from storage bingo:registries preferences.custom_hud
execute if score @s bingo.pref matches 5 run function #bingo:preferences/custom_hud
execute if score @s bingo.pref matches 5 run tellraw @s ["\n\n\n\n\n=== ", {"translate": "bingo.preferences.custom_hud.title", "bold": true, "color": "green"}, " ===\n\n", {"translate": "bingo.preferences.custom_hud.description", "color": "gray"}, "\n"]

execute if score @s bingo.pref matches 6..8 run function bingo:preferences/custom_hud/show_disabled
execute if score @s bingo.pref matches 9 run function bingo:preferences/custom_hud/show_col0
execute if score @s bingo.pref matches 10 run function bingo:preferences/custom_hud/show_col1

execute if score @s bingo.pref matches 12..31 run function bingo:preferences/custom_hud/add_disabled/exec
execute if score @s bingo.pref matches 32..46 run function bingo:preferences/custom_hud/adjust_col/col0
execute if score @s bingo.pref matches 49..66 run function bingo:preferences/custom_hud/adjust_col/col1

execute if score @s bingo.pref matches 70 run function bingo:preferences/custom_hud/component_settings/player_chunk_position_settings
execute if score @s bingo.pref matches 71 run function bingo:preferences/custom_hud/component_settings/enable_merged_chunk_coordinates

execute if score @s bingo.pref matches 72 run function bingo:preferences/custom_hud/component_settings/player_position_settings
execute if score @s bingo.pref matches 73 run function bingo:preferences/custom_hud/component_settings/disable_merged_chunk_coordinates/exec
execute if score @s bingo.pref matches 77 run function bingo:preferences/custom_hud/component_settings/show_compass_icon
execute if score @s bingo.pref matches 12..66 run scoreboard players set @s bingo.update_hud 1

data modify storage bingo:custom_hud players append from storage bingo:custom_hud currentPlayer
data modify storage bingo:custom_hud players append from storage tmp.bingo:preferences/hud skippedHuds[]

execute if score @s bingo.pref matches 67..69 run scoreboard players set $preferences.next_page bingo.tmp 11
execute if score @s bingo.pref matches 67..69 run scoreboard players set @s bingo.update_hud 1