#> bingo:game/emerald_detection/move_x/2
#
# @context
# 	entity Player
# 	position @s
# @within function bingo:game/emerald_detection/move_x/1

execute if score $emerald_detection.chunkx bingo.tmp matches 4.. run scoreboard players remove $emerald_detection.chunkx bingo.tmp 4
execute if score $emerald_detection.chunkx bingo.tmp matches ..1 positioned ~2 ~ ~ run function bingo:game/emerald_detection/move_x/3
execute if score $emerald_detection.chunkx bingo.tmp matches 2.. run function bingo:game/emerald_detection/move_x/3