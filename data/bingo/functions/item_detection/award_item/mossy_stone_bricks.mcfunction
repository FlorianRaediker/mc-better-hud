tellraw @a {"translate": "bingo.got_item", "with": [{"selector": "@s"}, {"translate": "block.minecraft.mossy_stone_bricks", "hoverEvent": {"action": "show_item", "contents": {"id": "minecraft:mossy_stone_bricks"}}}]}
execute as @e[type=minecraft:area_effect_cloud, tag=bingo_completed_item, tag=bingo_current_team, limit=1] run function bingo:item_detection/goals/announce_completed_goals
tag @s add bingo_clear_mossy_stone_bricks
schedule function bingo:item_detection/clear_item/mossy_stone_bricks 1