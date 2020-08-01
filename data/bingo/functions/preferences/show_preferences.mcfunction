tellraw @s[scores={bingo_preference=1},] ["\n\n\n=== ", {"text": "Change Prefernces", "bold": true, "color": "green"}, " ===\n\n[", {"text": "Change Card Position", "color":"#00c3ff", "clickEvent": {"action": "run_command", "value": "/trigger bingo_preference set 2"}, "hoverEvent": {"action": "show_text", "contents": "Changes where on the screen the Bingo card is displayed"}}, "]"]

tellraw @s[scores={bingo_preference=2},] ["\n\n\n=== ",{"text":"Change Card Position","bold":true,"color":"green"}," ===\n\n[",{"text":"Left of Hotbar","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 0"},"hoverEvent":{"action":"show_text","contents":"Postions the Bingo card left of the hotbar."}},"]\n[",{"text":"Right of Hotbar","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_preference set 3"},"hoverEvent":{"action":"show_text","contents":"Postions the Bingo card right of the hotbar."}},"]\n[",{"text":"Left Edge","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_preference set 4"},"hoverEvent":{"action":"show_text","contents":["Postions the Bingo card on the left edge of the screen.\n",{"text":"Only works properly on a 16:9 display.","color":"yellow"}]}},"]\n[",{"text":"Right Edge","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_preference set 5"},"hoverEvent":{"action":"show_text","contents":["Postions the Bingo card on the right edge of the screen.\n",{"text":"Only works properly on a 16:9 display.","color":"yellow"}]}},"]\n\n[",{"text":"Back","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_preference set 1"},"hoverEvent":{"action":"show_text","contents":"Go back to previous page"}},"]"]

tellraw @s[scores={bingo_preference=3},] ["\n\n\n=== ",{"text":"Change Card Position","bold":true,"color":"green"}," ===\n- ",{"text":"Right of Hotbar","bold":true},"\n",{"text":"This setting requires more information about your Minecraft settings.\nPlease take a look at your Attack Indicator setting in Options -> Video Settings and choose one of the following:"},"\n\n[",{"text":"Attack Indicator: Hotbar","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 9"},"hoverEvent":{"action":"show_text","contents":"Adds an extra space to make room for the attack indicator next to the hotbar."}},"]\n[",{"text":"Attack Indicator: Crosshair or Off","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 8"},"hoverEvent":{"action":"show_text","contents":"Positions the Bingo crad directly next to the hotbar."}},"]\n\n[",{"text":"Back","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_preference set 2"},"hoverEvent":{"action":"show_text","contents":"Go back to previous page"}},"]"]

tellraw @s[scores={bingo_preference=4},] ["\n\n\n=== ",{"text":"Change Card Position","bold":true,"color":"green"}," ===\n- ",{"text":"Left Edge","bold":true},"\n",{"text":"Only works properly on a 16:9 display.","color":"yellow"},"\n",{"text":"This setting requires more information about your Minecraft settings.\nPlease take a look at your GUI Scale setting in Options -> Video Settings. In case it is set to auto, please cycle the setting to find the scale auto is using.\nPlease choose one of the following:"},"\n\n[",{"text":"GUI Scale: 1","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 1"},"hoverEvent":{"action":"show_text","contents":"Aligns the Bingo card to the left edge for GUI Scale 1."}},"]\n[",{"text":"GUI Scale: 2","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 2"},"hoverEvent":{"action":"show_text","contents":"Aligns the Bingo card to the left edge for GUI Scale 2."}},"]\n[",{"text":"GUI Scale: 3","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 3"},"hoverEvent":{"action":"show_text","contents":"Aligns the Bingo card to the left edge for GUI Scale 3."}},"]\n[",{"text":"GUI Scale: 4","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 4"},"hoverEvent":{"action":"show_text","contents":"Aligns the Bingo card to the left edge for GUI Scale 4."}},"]\n\n[",{"text":"Back","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_preference set 2"},"hoverEvent":{"action":"show_text","contents":"Go back to previous page"}},"]"]

tellraw @s[scores={bingo_preference=5},] ["\n\n\n=== ",{"text":"Change Card Position","bold":true,"color":"green"}," ===\n- ",{"text":"Right Edge","bold":true},"\n",{"text":"Only works properly on a 16:9 display.","color":"yellow"},"\n",{"text":"This setting requires more information about your Minecraft settings.\nPlease take a look at your GUI Scale setting in Options -> Video Settings. In case it is set to auto, please cycle the setting to find the scale auto is using.\nPlease choose one of the following:"},"\n\n[",{"text":"GUI Scale: 1","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 10"},"hoverEvent":{"action":"show_text","contents":"Aligns the Bingo card to the left edge for GUI Scale 1."}},"]\n[",{"text":"GUI Scale: 2","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 11"},"hoverEvent":{"action":"show_text","contents":"Aligns the Bingo card to the left edge for GUI Scale 2."}},"]\n[",{"text":"GUI Scale: 3","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 12"},"hoverEvent":{"action":"show_text","contents":"Aligns the Bingo card to the left edge for GUI Scale 3."}},"]\n[",{"text":"GUI Scale: 4","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_card_pos set 13"},"hoverEvent":{"action":"show_text","contents":"Aligns the Bingo card to the left edge for GUI Scale 4."}},"]\n\n[",{"text":"Back","color":"#00c3ff","clickEvent":{"action":"run_command","value":"/trigger bingo_preference set 2"},"hoverEvent":{"action":"show_text","contents":"Go back to previous page"}},"]"]

scoreboard players reset @s bingo_preference