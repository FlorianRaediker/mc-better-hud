#> bingo:item_detection/items/gray_dye
#
# Triggered when the player obtains a minecraft:gray_dye
#
# @within advancement bingo:item_detection/gray_dye
# @handles advancement bingo:item_detection/gray_dye

#>
# @private
#declare score_holder $item_detect/gray_dye.success

execute store success score $item_detect/gray_dye.success bingo.tmp if data storage bingo:card slots[{item:{id:"bingo:gray_dye"}}] run data modify storage bingo:card slots[{item:{id:"bingo:gray_dye"}}].selected set value true
execute if score $item_detect/gray_dye.success bingo.tmp matches 1 run function bingo:item_detection/helper/check_and_announce