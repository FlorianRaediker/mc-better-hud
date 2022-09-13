#> bingo:lobby/player_tick
#
# This function is executed for every player in the lobby every tick
#
# @within function bingo:lobby/tick
# @context entity Current player

# change preferences
execute unless score @s bingo.pref matches 0 run function bingo:preferences/show
scoreboard players enable @s bingo.pref
