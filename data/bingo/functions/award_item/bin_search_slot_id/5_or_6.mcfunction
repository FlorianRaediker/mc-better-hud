execute if entity @s[scores={bingo_slot_id=5}] as @e[type=minecraft:area_effect_cloud, tag=bingo_current_team, limit=1] unless entity @s[tag=bingo_got_slot5] run function bingo:award_item/bin_search_slot_id/5
execute if entity @s[scores={bingo_slot_id=6}] as @e[type=minecraft:area_effect_cloud, tag=bingo_current_team, limit=1] unless entity @s[tag=bingo_got_slot6] run function bingo:award_item/bin_search_slot_id/6