#next to hotbar
execute if score @s bingo_card_pos matches 0 run data merge storage bingo:tmp {cardOffset:'{"translate":"space.91"}',cardNegOffset:'{"translate":"space.-91"}'}
#next to attack indicator
execute if score @s bingo_card_pos matches 1 run data merge storage bingo:tmp {cardOffset:'{"translate":"space.121"}',cardNegOffset:'{"translate":"space.-121"}'}
#right edge (gui 1)
execute if score @s bingo_card_pos matches 2 run data merge storage bingo:tmp {cardOffset:'{"translate":"space.856"}',cardNegOffset:'{"translate":"space.-856"}'}
#right edge (gui 2)
execute if score @s bingo_card_pos matches 3 run data merge storage bingo:tmp {cardOffset:'{"translate":"space.376"}',cardNegOffset:'{"translate":"space.-376"}'}
#right edge (gui 3)
execute if score @s bingo_card_pos matches 4 run data merge storage bingo:tmp {cardOffset:'{"translate":"space.216"}',cardNegOffset:'{"translate":"space.-216"}'}
#right edge (gui 4)
execute if score @s bingo_card_pos matches 5 run data merge storage bingo:tmp {cardOffset:'{"translate":"space.136"}',cardNegOffset:'{"translate":"space.-136"}'}