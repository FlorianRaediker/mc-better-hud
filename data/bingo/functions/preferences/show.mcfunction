#> bingo:preferences/show
#
# Shows the preferences page the player just selected.
#
# @within function bingo:lobby/player_tick
# @context entity Player who triggered bingo.pref
# @user
# @reads storage bingo:registries preferences.custom_hud.main

#>
# This storage contains the menuOptions nbt, which can be modified in functions
# referenced in #bingo:preferences/* function tags to set disabled and hidden
# attributes on specific entries.
#
# @api
#declare storage io.bingo:preferences
#>
# @within bingo:preferences/**
#declare storage tmp.bingo:preferences

execute if score @s bingo.pref matches 5..78 run function bingo:preferences/custom_hud/show

execute if score @s bingo.pref matches 1..5 run function bingo:preferences/print_menu_items
scoreboard players reset @s bingo.pref

#>
# In case an action happened and in the next tick a different page should be
# shown, this score is set.
#
# @within function bingo:preferences/**
#declare score_holder $preferences.next_page
execute if score $preferences.next_page bingo.tmp matches -2147483648.. run scoreboard players operation @s bingo.pref = $preferences.next_page bingo.tmp
scoreboard players reset $preferences.next_page bingo.tmp