#> bingo:item_detection/helper/goals/bingo/row/5/3
#
# @within function bingo:item_detection/helper/goals/bingo/row/5/2

#>
# @private
#declare score_holder $item_detect/bingo/row/5/3.success

execute store success score $item_detect/bingo/row/5/3.success bingo.tmp run data modify storage temp:bingo.item_detect/bingo/row/5 icon set from storage bingo:card teams[-1].slots[22]
execute if score $item_detect/bingo/row/5/3.success bingo.tmp matches 0 run function bingo:item_detection/helper/goals/bingo/row/5/4