#built using mc-build (https://github.com/mc-build/mc-build)

setblock 100 -64 100 minecraft:yellow_shulker_box
data modify storage mizab:drop_item Item set from entity @s SelectedItem
data modify block 100 -64 100 Items append from storage mizab:drop_item Item
item replace entity @s weapon.mainhand with minecraft:air
loot spawn ^ ^1 ^2 mine 100 -64 100 minecraft:air{drop_contents: 1b}