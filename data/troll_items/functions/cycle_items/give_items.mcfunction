#built using mc-build (https://github.com/mc-build/mc-build)

item replace entity @s hotbar.0 with carrot_on_a_stick{display:{Name:'{"text":"Backward","color":"gold","italic":false}'},CustomModelData:111001} 1
scoreboard players set @s item_select 0
function troll_items:cycle_items/cycle_item_check
item replace entity @s hotbar.8 with carrot_on_a_stick{display:{Name:'{"text":"Forward","color":"gold","italic":false}'},CustomModelData:111002} 1