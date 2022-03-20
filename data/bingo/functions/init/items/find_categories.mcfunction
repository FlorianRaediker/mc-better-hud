#> bingo:init/items/find_categories
#
# Finds all categories this item belongs to
#
# Moves the categories to tmp.bingo:init categories. All skipped categories
# will be part of skippedCategories.
#
# This means, at the end, all categories in that array need to be added back to
# the original list
#
# @within
# 	function bingo:init/items
# 	function bingo:init/items/find_categories
# @writes storage bingo:items categories
# @output storage tmp.bingo:init categories

#>
# Indicates whether a category was checked in this iteration.
#
# @within
# 	function bingo:init/items
# 	function bingo:init/items/find_categories
#declare score_holder $init/items/find_cat.category_exists

data modify storage tmp.bingo:init checkCategories set from storage tmp.bingo:init itemCategories
data remove storage tmp.bingo:init checkedCategories

function bingo:init/items/check_categories
data modify storage tmp.bingo:init itemCategories set from storage tmp.bingo:init checkCategories
data modify storage tmp.bingo:init itemCategories append from storage tmp.bingo:init checkedCategories[]

execute if score $init/items/find_cat.is_different bingo.tmp matches 1 run data modify storage tmp.bingo:init skippedCategories append from storage bingo:items categories[-1]
execute if score $init/items/find_cat.is_different bingo.tmp matches 0 run data modify storage tmp.bingo:init categories append from storage bingo:items categories[-1]
execute store success score $init/items/find_cat.category_exists bingo.tmp run data remove storage bingo:items categories[-1]

execute if score $init/items/find_cat.category_exists bingo.tmp matches 0 run tellraw @a [{"text": "[", "color": "red"}, {"translate": "bingo.logging.error"}, "] ", {"translate": "bingo.setup.error.unknown_category", "with": [{"storage": "tmp.bingo:init", "nbt": "items[-1].id"}, {"storage": "tmp.bingo:init", "nbt": "category"}]}]

execute unless score $init/items/find_cat.category_exists bingo.tmp matches 0 if data storage tmp.bingo:init itemCategories[0] run function bingo:init/items/find_categories