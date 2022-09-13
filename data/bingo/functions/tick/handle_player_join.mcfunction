#> bingo:tick/handle_player_join
#
# This function runs for every player who just reconnected.
#
# @within tag/function bingo:player_reconnect
# @handles #bingo:player_reconnect
# @context entity Player who reconnected

scoreboard players set @s bingo.update_hud 1
trigger bingo.resources

scoreboard players reset @s bingo.reconnect