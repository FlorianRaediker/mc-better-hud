tellraw @a {"translate": "bingo.got_item", "with": [{"selector": "@s"}, {"translate": "block.minecraft.dark_oak_sapling", "hoverEvent": {"action": "show_item", "contents": {"id": "minecraft:dark_oak_sapling"}}}]}
execute as @e[type=minecraft:area_effect_cloud, tag=bingo_completed_item, tag=bingo_current_team, limit=1] run function bingo:item_detection/goals/announce_completed_goals
tag @s add bingo_clear_dark_oak_sapling
schedule function bingo:item_detection/clear_item/dark_oak_sapling 1