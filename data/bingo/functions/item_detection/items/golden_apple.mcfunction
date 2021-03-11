#> bingo:item_detection/items/golden_apple
#
# Triggered when the player obtains a minecraft:golden_apple
#
# @within advancement bingo:item_detection/golden_apple
# @handles advancement bingo:item_detection/golden_apple

#>
# @private
#declare score_holder $item_detect/golden_apple.success

execute store success score $item_detect/golden_apple.success bingo.tmp if data storage bingo:card slots[{item:{id:"bingo:golden_apple"}}] run data modify storage bingo:card slots[{item:{id:"bingo:golden_apple"}}].selected set value true
execute if score $item_detect/golden_apple.success bingo.tmp matches 1 run function bingo:item_detection/helper/check_and_announce