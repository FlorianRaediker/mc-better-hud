execute if score $allow_fixed bingo_tmp matches 0 if data storage bingo:tmp playerConfigs[0].fixed run function bingo:lobby/player_settings/find_not_fixed
execute if score $stash_prev bingo_tmp matches 1 run data modify storage bingo:player configurations append from storage bingo:tmp playerConfigs[0]
data remove storage bingo:tmp playerConfigs[0]

scoreboard players remove $j bingo_tmp 1
execute if score $j bingo_tmp matches 1.. run function bingo:lobby/player_settings/find_config_on_page