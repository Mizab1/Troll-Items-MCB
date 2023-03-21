import ./macros/internal_macros.mcm
function load{
    scoreboard objectives add rc_detect minecraft.used:minecraft.carrot_on_a_stick
    scoreboard objectives add item_select dummy
    gamerule keepInventory true
    gamerule doDaylightCycle false
    gamerule doWeatherCycle false


    # shulker box technique
    forceload add 100 100
}

function tick{
    execute as @a[scores={rc_detect=1..}] at @s run{
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110001}}}] run{
            summon tnt ~ ~ ~ {Fuse:40}
            effect give @s resistance 6 100 true
            tellraw @s {"text":"You summoned a TNT", "color":"gold"}
        }
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110002}}}] run{
            playsound minecraft:entity.creeper.primed master @a ~ ~ ~ 1
            tellraw @s {"text":"You played a creeper sound", "color":"gold"}
        }
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110003}}}] run{
            execute at @a[tag=!troller, limit=1, sort=nearest] run summon zombie ~6 ~ ~ {IsBaby:1b} 
            execute at @a[tag=!troller, limit=1, sort=nearest] run summon zombie ~-6 ~ ~ {IsBaby:1b} 
            tellraw @s {"text":"You summon a baby zombie at the closest player's location", "color":"gold"}
        }
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110004}}}] run{
            execute as @a[tag=!troller, limit=1, sort=nearest] at @s run function troll_items:drop_item_from_mainhand
            tellraw @s {"text":"You made the person to drop their item", "color":"gold"}
        }
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110005}}}] run{
            setblock ~ ~ ~ trapped_chest
            setblock ~ ~-2 ~ tnt 
            tellraw @s {"text":"You placed Trapped Chest at your position", "color":"gold"}
        }
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110006}}}] run{
            fill ~-5 ~-5 ~-5 ~5 ~5 ~5 minecraft:barrier keep
            tellraw @s {"text":"You placed Invisible Wall at your position", "color":"gold"}
        }
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110007}}}] run{
            execute at @a[tag=!troller, limit=1, sort=nearest] run fill ~-1 ~-20 ~-1 ~1 ~ ~1 minecraft:air
            tellraw @s {"text":"You digged a hole at your victim's position", "color":"gold"}
        }


        # Backward and forward button
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:111001}}}] run{
            execute if score @s item_select matches 0.. run{
                scoreboard players remove @s item_select 1
                playsound minecraft:block.stone_button.click_off master @s ~ ~ ~ 1 1
                function troll_items:cycle_items/cycle_item_check
            }
            execute if score @s item_select matches -1 run{
                playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 0.5 1.2
            }
        }
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:111002}}}] run{
            execute if score @s item_select matches ..19 run{
                scoreboard players add @s item_select 1
                playsound minecraft:block.stone_button.click_on master @s ~ ~ ~ 1 1
                function troll_items:cycle_items/cycle_item_check
            }
            execute if score @s item_select matches 20 run{
                playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 0.5 1.2
            }
        }
        # reset click
        scoreboard players reset @s rc_detect
    }
}

function drop_item_from_mainhand{
    setblock 100 -64 100 minecraft:yellow_shulker_box
    data modify storage mizab:drop_item Item set from entity @s SelectedItem
    data modify block 100 -64 100 Items append from storage mizab:drop_item Item
    item replace entity @s weapon.mainhand with minecraft:air 
    loot spawn ^ ^1 ^2 mine 100 -64 100 minecraft:air{drop_contents: 1b}
}

    <%%
        storage.get("ITEMS_VAR")
        items = [
            `carrot_on_a_stick{display:{Name:'{"text":"Summon TNT","color":"gold","italic":false}',Lore:['{"text":"Summons a TNT at your position","color":"dark_aqua"}']},CustomModelData:110001} 1`,
            `carrot_on_a_stick{display:{Name:'{"text":"Creeper Sound","color":"gold","italic":false}',Lore:['{"text":"Create creeper sound at your position","color":"dark_aqua"}']},CustomModelData:110002} 1`,
            `carrot_on_a_stick{display:{Name:'{"text":"Summon Baby Zombie","color":"gold","italic":false}',Lore:['{"text":"Summon baby zombie at the closest players excluding troller","color":"dark_aqua"}']},CustomModelData:110003} 1`,
            `carrot_on_a_stick{display:{Name:'{"text":"Fetch Items","color":"gold","italic":false}',Lore:['{"text":"Drop the current item in closest players hand","color":"dark_aqua"}']},CustomModelData:110004} 1`,
            `carrot_on_a_stick{display:{Name:'{"text":"TNT Trapped Chest","color":"gold","italic":false}',Lore:['{"text":"Places a TNT Trapped chect at your position","color":"dark_aqua"}']},CustomModelData:110005} 1`,
            `carrot_on_a_stick{display:{Name:'{"text":"Invisible Wall","color":"gold","italic":false}',Lore:['{"text":"Places invisible wall (10x10x10) at your position","color":"dark_aqua"}']},CustomModelData:110006} 1`,
            `carrot_on_a_stick{display:{Name:'{"text":"Instant Hole","color":"gold","italic":false}',Lore:['{"text":"Dig 3x3 hole at your position","color":"dark_aqua"}']},CustomModelData:110007} 1`,
            `coarse_dirt{display:{Name:'{"text":"Block of Diamond","italic":false}'}} 64`,
            `chest{BlockEntityTag:{LootTable:"minecraft:chests/useless_chest"}} 64`,
            `oak_log`,
            `air`,
            `air`,
            `air`,
            `air`,
            `air`,
            `air`,
            `air`,
            `air`,
            `air`
        ]
        console.log(items.length)
        storage.set("ITEMS_LENGTH", items.length)
        storage.set("ITEMS", items)
    %%>
dir cycle_items{
    function cycle_item_check{
        LOOP((storage.get("ITEMS_LENGTH") - 7) + 1,i){
            execute as @a[tag=troller] at @s if score @s item_select matches <%i%> run{
                <%%
                    for (let j = 1; j <= 7; j++) {
                        emit(`item replace entity @s hotbar.${j} with ${storage.get("ITEMS")[(j+i)-1]}`)
                    }
                %%>
            }
        }
    }
    function give_items{
        item replace entity @s hotbar.0 with carrot_on_a_stick{display:{Name:'{"text":"Backward","color":"gold","italic":false}'},CustomModelData:111001} 1
        scoreboard players set @s item_select 0
        function troll_items:cycle_items/cycle_item_check
        item replace entity @s hotbar.8 with carrot_on_a_stick{display:{Name:'{"text":"Forward","color":"gold","italic":false}'},CustomModelData:111002} 1
    }
}

function give_sticks{
    give_stick <Summon TNT> <Summons a TNT at your position> 110001
    give_stick <Creeper Sound> <Create creeper sound at your position> 110002
    give_stick <Summon Baby Zombie> <Summon baby zombie at the closest player\'s excluding troller> 110003
    give_stick <Fetch Items> <Drop the current item in closest player\'s hand> 110004
    give_stick <TNT Trapped Chest> <Places a TNT Trapped chect at your position> 110005
    give_stick <Invisible Wall> <Places invisible wall (10x10x10) at your position> 110006
    give_stick <Instant Hole> <Dig 3x3 hole at your position> 110007
}