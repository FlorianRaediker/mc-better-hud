#> bingo:item_detection/helper/goals/bingo/col/4/3
#
# @within function bingo:item_detection/helper/goals/bingo/col/4/2

#>
# @private
#declare score_holder $item_detect/bingo/col/4/3.success

execute store success score $item_detect/bingo/col/4/3.success bingo.tmp run data modify storage temp:bingo.item_detect/bingo/col/4 icon set from storage temp:bingo.item_detect/bingo/col/4 slots[13]
execute if score $item_detect/bingo/col/4/3.success bingo.tmp matches 1 run function bingo:item_detection/helper/goals/bingo/col/4/4