execute if entity @s[scores={bingo_slot_id=0}] as @e[type=minecraft:area_effect_cloud, tag=bingo_current_team, limit=1] unless entity @s[tag=bingo_got_slot0] run function bingo:award_item/bin_search_slot_id/0
execute if entity @s[scores={bingo_slot_id=1}] as @e[type=minecraft:area_effect_cloud, tag=bingo_current_team, limit=1] unless entity @s[tag=bingo_got_slot1] run function bingo:award_item/bin_search_slot_id/1