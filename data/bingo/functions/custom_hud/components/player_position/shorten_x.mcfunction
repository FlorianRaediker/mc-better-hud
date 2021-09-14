#> bingo:custom_hud/components/player_position/shorten_x
#
# This function shortens
#
# @within function bingo:custom_hud/components/player_position/shorten

#>
# The remaining digits of the x coordinate
#
# @within
# 	function bingo:custom_hud/components/player_position/shorten_x
# 	function bingo:custom_hud/components/player_position/shorten_x_iter
#declare score_holder $custom_hud/player_pos.short_x
#>
# The current amount of removed digits
#
# @within
# 	function bingo:custom_hud/components/player_position/shorten_x
# 	function bingo:custom_hud/components/player_position/shorten_x_iter
#declare score_holder $custom_hud/player_pos.removed_x

# Use absolute value for now so that integer division cuts of digits (Mojang
# uses floor_div and floor_mod, which is a good thing in most applications and
# can easily be mitigated like this for when it isn't)
scoreboard players operation $custom_hud/player_pos.short_x bingo.tmp = $custom_hud/player_pos.abs_x bingo.tmp

# At least 2 digits need to be removed.
scoreboard players operation $custom_hud/player_pos.short_x bingo.tmp /= 100 bingo.const
scoreboard players set $custom_hud/player_pos.removed_x bingo.tmp 2
scoreboard players remove $custom_hud/width.characters bingo.io 1

# Remove 2 digits (width 12) and add per coordinate:
#   - decimal point (width 2)
#   - Either k for kilo (width 5) or M for million (width 6)
# Total is either 5 or 4
execute if score $custom_hud/player_pos.abs_x bingo.tmp matches ..999999 run scoreboard players add $custom_hud/width.padding bingo.io 5
execute if score $custom_hud/player_pos.abs_x bingo.tmp matches ..999999 run data modify storage bingo:custom_hud params.bingo.player_position.xChar set value "k"
execute unless score $custom_hud/player_pos.abs_x bingo.tmp matches ..999999 run scoreboard players add $custom_hud/width.padding bingo.io 4
execute unless score $custom_hud/player_pos.abs_x bingo.tmp matches ..999999 run data modify storage bingo:custom_hud params.bingo.player_position.xChar set value "M"

execute if score $custom_hud/width.characters bingo.tmp matches 12.. if score $custom_hud/player_pos.abs_x bingo.tmp >= $custom_hud/player_pos.abs_z bingo.tmp run function bingo:custom_hud/components/player_position/shorten_x_iter

#>
# Current decimal digits
#
# @within
# 	function bingo:custom_hud/components/player_position/shorten_x
# 	function bingo:custom_hud/components/player_position/calculate_fixed_point_x
#declare score_holder $custom_hud/player_pos.decimal_digits
#>
# @within
# 	function bingo:custom_hud/components/player_position/shorten_x
# 	function bingo:custom_hud/components/player_position/calculate_fixed_point_x
#declare score_holder $custom_hud/player_pos.ten_pow

#>
# Integer portion of x
#
# @within
# 	function bingo:custom_hud/components/player_position/shorten_x
# 	function bingo:custom_hud/components/player_position/calculate_fixed_point_x
#declare score_holder $custom_hud/player_pos.int_x
scoreboard players operation $custom_hud/player_pos.int_x bingo.tmp = $custom_hud/player_pos.short_x bingo.tmp
#>
# Decimal portion of x
#
# @within
# 	function bingo:custom_hud/components/player_position/shorten_x
# 	function bingo:custom_hud/components/player_position/calculate_fixed_point_x
#declare score_holder $custom_hud/player_pos.dec_x
scoreboard players set $custom_hud/player_pos.dec_x bingo.tmp 0
data modify storage bingo:custom_hud params.bingo.player_position.xFillerZeros set value [""]
scoreboard players set $custom_hud/player_pos.ten_pow bingo.tmp 1
scoreboard players operation $custom_hud/player_pos.decimal_digits bingo.tmp = $custom_hud/player_pos.removed_x bingo.tmp
execute if score $custom_hud/player_pos.abs_x bingo.tmp matches 1000000.. run function bingo:custom_hud/components/player_position/calculate_fixed_point_x
execute unless score $custom_hud/player_pos.abs_x bingo.tmp matches 1000000.. if score $custom_hud/player_pos.removed_x bingo.tmp matches ..2 run function bingo:custom_hud/components/player_position/calculate_fixed_point_x

execute if score $custom_hud/player_pos.x bingo.tmp matches ..-1 run scoreboard players operation $custom_hud/player_pos.int_x bingo.tmp *= -1 bingo.const

data modify storage tmp.bingo:custom_hud component.textComponent set value '[{"storage": "bingo:custom_hud", "nbt": "params.bingo.player_position.xInt"}, ".", {"storage": "bingo:custom_hud", "nbt": "params.bingo.player_position.xFillerZeros", "interpret": true}, {"storage": "bingo:custom_hud", "nbt": "params.bingo.player_position.xDec"}, {"storage": "bingo:custom_hud", "nbt": "params.bingo.player_position.xChar"}, " ", {"storage": "bingo:custom_hud", "nbt": "params.bingo.player_position.z"}]'

execute store result storage bingo:custom_hud params.bingo.player_position.xInt int 1 run scoreboard players get $custom_hud/player_pos.int_x bingo.tmp
execute store result storage bingo:custom_hud params.bingo.player_position.xDec int 1 run scoreboard players get $custom_hud/player_pos.dec_x bingo.tmp