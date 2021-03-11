#> bingo:item_detection/items/name_tag
#
# Triggered when the player obtains a minecraft:name_tag
#
# @within advancement bingo:item_detection/name_tag
# @handles advancement bingo:item_detection/name_tag

#>
# @private
#declare score_holder $item_detect/name_tag.success

execute store success score $item_detect/name_tag.success bingo.tmp if data storage bingo:card slots[{item:{id:"bingo:name_tag"}}] run data modify storage bingo:card slots[{item:{id:"bingo:name_tag"}}].selected set value true
execute if score $item_detect/name_tag.success bingo.tmp matches 1 run function bingo:item_detection/helper/check_and_announce