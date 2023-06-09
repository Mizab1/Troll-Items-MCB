import ./macros/internal_macros.mcm
function load{
    scoreboard objectives add rc_detect minecraft.used:minecraft.carrot_on_a_stick
    scoreboard objectives add item_select dummy
    scoreboard objectives add LANG_MC_INTERNAL dummy
    gamerule keepInventory true
    gamerule doDaylightCycle false
    gamerule doWeatherCycle false
    gamerule commandModificationBlockLimit 999999999

    # shulker box technique
    forceload add 100 100
}



clock 1s{
    execute at @a[tag=block_destruct_victim] positioned ~ ~-1 ~ run{
        setblock ~ ~ ~ air destroy
    }
}
function tick{
    # Give Invisibility to the troller
    execute as @a[tag=troller] run{
        effect give @s invisibility 15 1 true
        effect give @s resistance 15 120 true
        effect give @s regeneration 15 120 true
        effect give @s night_vision 15 120 true
        
    }

    # Item place logic
    execute as @e[type=endermite] at @s run{
        #trapped chest
        execute if entity @s[tag=trapped_chest_en] run{
            setblock ~ ~ ~ trapped_chest
            setblock ~ ~-2 ~ tnt
            kill @s
        }

        #creeper hole
        execute if entity @s[tag=creeper_hole_en] run{
            fill ~-2 ~-4 ~-2 ~2 ~-1 ~2 stone
            summon armor_stand ~ ~-3 ~ {Marker:1b,Invisible:1b,Tags:["creeper_hole"]}
            fill ~-1 ~-3 ~-1 ~1 ~ ~1 air
            kill @s
        }
    }

    # Items detection logic
    execute as @a[scores={rc_detect=1..}] at @s run{
        # SUMMON tnt
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110001}}}] run{
            summon tnt ~ ~ ~ {Fuse:40}
            tellraw @s {"text":"You summoned a TNT", "color":"gold"}
        }
        # creeper sound
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110002}}}] run{
            playsound minecraft:entity.creeper.primed master @a ~ ~ ~ 1
            tellraw @s {"text":"You played a creeper sound", "color":"gold"}
        }
        # spawn baby zombie
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110003}}}] run{
            execute at @a[tag=!troller, limit=1, sort=nearest] run summon zombie ~6 ~ ~ {IsBaby:1b} 
            execute at @a[tag=!troller, limit=1, sort=nearest] run summon zombie ~-6 ~ ~ {IsBaby:1b} 
            tellraw @s {"text":"You summon a baby zombie at the closest player's location", "color":"gold"}
        }
        # drop items
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110004}}}] run{
            execute as @a[tag=!troller, limit=1, sort=nearest] at @s run function troll_items:drop_item_from_mainhand
            tellraw @s {"text":"You made the person to drop their item", "color":"gold"}
        }
        # invisble wall
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110006}}}] run{
            fill ~-5 ~-5 ~-5 ~5 ~5 ~5 minecraft:barrier keep
            tellraw @s {"text":"You placed Invisible Wall at your position", "color":"gold"}
        }
        # instant hole
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110007}}}] run{
            execute at @a[tag=!troller, limit=1, sort=nearest] run fill ~-1 ~-20 ~-1 ~1 ~ ~1 minecraft:air
            tellraw @s {"text":"You digged a hole at your victim's position", "color":"gold"}
        }
        # trampoline 
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110008}}}] run{
            summon armor_stand ~ ~ ~ {Marker:1b,Invisible:1b,Tags:["trampoline"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:100001}}]}
            tellraw @s {"text":"You placed hidden trampoline at you position", "color":"gold"}
        }
        # Fire trap 
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110010}}}] run{
            fill ~-2 ~ ~-2 ~2 ~ ~2 fire
            tellraw @s {"text":"You placed an array of fire at your position", "color":"gold"}
        }
        # Spider trap 
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110011}}}] run{
            execute at @a[tag=!troller, limit=1, sort=nearest] run{
                LOOP(10,i){
                    summon spider ~<%Math.sin(i) * 6%> ~ ~<%Math.cos(i) * 6%> 
                }
            }
            tellraw @s {"text":"You summoned spiders at the closest players location", "color":"gold"}
        }
        # Teleport 
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110012}}}] run{
            execute as @a[tag=!troller, limit=1, sort=nearest] at @s run{
                spreadplayers ~ ~ 5 10 false @a[tag=troller]
            }
            tellraw @s {"text":"You teleported at the closest players location", "color":"gold"}
        }
        # Firework
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110013}}}] run{
            execute as @a[tag=!troller, limit=1, sort=nearest] at @s run{
                LOOP(20,i){
                    summon firework_rocket ~<%Math.sin(i) * 6%> ~<%Math.random() * 3%> ~<%Math.cos(i) * 6%> {LifeTime:10,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;13106959,5073663],FadeColors:[I;3394047]},{Type:1,Colors:[I;16711680,2555730,4045055]},{Type:4,Colors:[I;16777215]}]}}}}
                }
            }
            tellraw @s {"text":"You summoned fireworks at the closest players location", "color":"gold"}
        }
        # Change speed
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110014}}}] run{
            execute anchored eyes positioned ^ ^ ^1 if block ~ ~ ~ air run{
                # particle crit ~ ~ ~ 0 0 0 0 1 normal @s
                execute if block ~ ~ ~ air unless entity @e[type=!player,dx=0] positioned ^ ^ ^1 run function $block
                execute as @a[tag=!troller, dx=0] at @s run{
                    effect give @s speed 15 100 true
                }
            }
            tellraw @s {"text":"You used Change Speed item on a player", "color":"gold"}
        }
        # Creeper Rain
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110015}}}] run{
            execute anchored eyes positioned ^ ^ ^1 if block ~ ~ ~ air run{
                # particle crit ~ ~ ~ 0 0 0 0 1 normal @s
                execute if block ~ ~ ~ air unless entity @e[type=!player,dx=0] positioned ^ ^ ^1 run function $block
                execute as @a[tag=!troller, dx=0] at @s run{
                    <%%
                        function getRandomArbitrary(min, max) {
                            return Math.random() * (max - min) + min;
                        }
                        for (let i = 0; i < 30; i++) {
                            emit(`summon creeper ~${Math.sin(i) * 6} ~${getRandomArbitrary(10, 41)} ~${Math.cos(i) * 6}`)
                        }
                    %%>
                }
            }
            tellraw @s {"text":"You used Raining Creeper item on a player", "color":"gold"}
        }
        # Clear Item
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110016}}}] run{
            execute anchored eyes positioned ^ ^ ^1 if block ~ ~ ~ air run{
                # particle crit ~ ~ ~ 0 0 0 0 1 normal @s
                execute if block ~ ~ ~ air unless entity @e[type=!player,dx=0] positioned ^ ^ ^1 run function $block
                execute as @a[tag=!troller, dx=0] at @s run{
                    item replace entity @s weapon.mainhand with air
                }
            }
            tellraw @s {"text":"You cleared the item in mainhand of a player", "color":"gold"}
        }
        # Block destruct
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110017}}}] run{
            execute anchored eyes positioned ^ ^ ^1 if block ~ ~ ~ air run{
                # particle crit ~ ~ ~ 0 0 0 0 1 normal @s
                execute if block ~ ~ ~ air unless entity @e[type=!player,dx=0] positioned ^ ^ ^1 run function $block
                execute as @a[tag=!troller, dx=0] at @s run{
                    tag @s add block_destruct_victim
                    schedule 30s replace{
                        tag @a[tag=block_destruct_victim] remove block_destruct_victim
                    }
                }
            }
            tellraw @s {"text":"You used Block Destructor item on a player", "color":"gold"}
        }
        # Convert Blocks
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110018}}}] run{
            execute anchored eyes positioned ^ ^ ^1 if block ~ ~ ~ air run{
                # particle crit ~ ~ ~ 0 0 0 0 1 normal @s
                execute if block ~ ~ ~ air unless entity @e[type=!player,dx=0] positioned ^ ^ ^1 run function $block
                execute as @a[tag=!troller, dx=0] at @s run{
                    execute(if block ~ ~-0.35 ~ minecraft:grass_block){
                        fill ~5 ~-1 ~5 ~-5 ~-3 ~-5 minecraft:lava replace grass_block
                        setblock ~ ~2 ~ stone
                        tp @s ~ ~3 ~
                    }else execute(if block ~ ~-0.35 ~ minecraft:stone){
                        fill ~5 ~ ~5 ~-5 ~3 ~-5 minecraft:lava replace stone
                    }else{
                        fill ~5 ~-1 ~5 ~-5 ~-3 ~-5 minecraft:lava replace #aestd1:all_but_air
                    }
                    # fill ~6 ~6 ~6 ~-6 ~-6 ~-6 minecraft:lava replace #aestd1:all_but_air
                    # setblock ~ ~2 ~ stone
                    # tp @s ~ ~3 ~
                }
            }
            tellraw @s {"text":"You converted the blocks to lava around a player", "color":"gold"}
        }
        # Nightmare Village
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110019}}}] run{
            LOOP(30,i){
                summon spider ~ ~6 ~
            }
            spreadplayers ~ ~ 4 20 true @e[type=minecraft:spider, distance=..30]
            <%%
                let blockAndAlternative = [
                    `cobblestone`,
                    `blackstone`,

                    `mossy_cobblestone`,
                    `blackstone`,

                    `cobblestone_stairs`,
                    `blackstone_stairs`,

                    `cobblestone_wall`,
                    `blackstone_wall`,

                    `oak_log`,
                    `dark_oak_log`,

                    `stripped_oak_wood`,
                    `stripped_dark_oak_wood`,

                    `stripped_oak_log`,
                    `stripped_dark_oak_log`,

                    `oak_planks`,
                    `dark_oak_planks`,

                    `oak_fence`,
                    `dark_oak_fence`,

                    `oak_stairs[facing=east]`,
                    `dark_oak_stairs[facing=east]`,

                    `oak_stairs[facing=west]`,
                    `dark_oak_stairs[facing=west]`,

                    `oak_stairs[facing=north]`,
                    `dark_oak_stairs[facing=north]`,

                    `oak_stairs[facing=south]`,
                    `dark_oak_stairs[facing=south]`,

                    `white_terracotta`,
                    `black_terracotta`,

                    `grass_block`,
                    `netherrack`,

                    `stone`,
                    `cobbled_deepslate`
                ]
                for (let i = 0; i < blockAndAlternative.length; i+=2) {
                    emit(`fill ~80 ~30 ~80 ~-80 ~-30 ~-80 ${blockAndAlternative[i+1]} replace ${blockAndAlternative[i]}`)  
                }
            %%>
            tellraw @s {"text":"You used Nightmare Village item", "color":"gold"}
        }
        # Random teleport
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:110020}}}] run{
            spreadplayers ~ ~ 40 80 false @a[tag=!troller]
            tellraw @s {"text":"You used Random Teleport item", "color":"gold"}
        }


        # Backward and forward button
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:111001}}}] run{
            execute if score @s item_select matches 1.. run{
                scoreboard players remove @s item_select 1
                playsound minecraft:block.stone_button.click_off master @s ~ ~ ~ 1 1
                function troll_items:cycle_items/cycle_item_check
            }
            execute if score @s item_select matches 0 run{
                playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 0.5 1.2
            }
        }
        execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{CustomModelData:111002}}}] run{
            execute if score @s item_select matches ..16 run{
                scoreboard players add @s item_select 1
                playsound minecraft:block.stone_button.click_on master @s ~ ~ ~ 1 1
                function troll_items:cycle_items/cycle_item_check
            }
            execute if score @s item_select matches 17 run{
                playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 0.5 1.2
            }
        }
        # reset click
        scoreboard players reset @s rc_detect
    }

    # Trampoline Logic 
    execute as @a[tag=!troller] at @s if entity @e[type=armor_stand, tag=trampoline, distance=..0.5] run{
        effect give @s levitation 1 100 true
    }

    # creeper hole logic
    execute as @e[type=armor_stand, tag=creeper_hole] at @s if entity @a[tag=!troller, distance=..2] run{
        LOOP(6,i){
            summon creeper ~ ~ ~
        }
        kill @s
    }

}

function drop_item_from_mainhand{
    setblock 100 -64 100 minecraft:yellow_shulker_box
    data modify storage mizab:drop_item Item set from entity @s SelectedItem
    data modify block 100 -64 100 Items append from storage mizab:drop_item Item
    item replace entity @s weapon.mainhand with minecraft:air
    loot spawn ^ ^1 ^2 mine 100 -64 100 minecraft:air{drop_contents: 1b}
}
function make_me_troller{
    tag @s add troller
    function troll_items:cycle_items/give_items
}

<%%
    items = [
        `carrot_on_a_stick{display:{Name:'{"text":"Summon TNT","color":"gold","italic":false}',Lore:['{"text":"Summons a TNT at your position","color":"dark_aqua"}']},CustomModelData:110001} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Creeper Sound","color":"gold","italic":false}',Lore:['{"text":"Create creeper sound at your position","color":"dark_aqua"}']},CustomModelData:110002} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Summon Baby Zombie","color":"gold","italic":false}',Lore:['{"text":"Summon baby zombie at the closest players excluding troller","color":"dark_aqua"}']},CustomModelData:110003} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Fetch Items","color":"gold","italic":false}',Lore:['{"text":"Drop the current item in closest players hand","color":"dark_aqua"}']},CustomModelData:110004} 1`,

        `endermite_spawn_egg{display:{Name:'{"text":"TNT Trapped Chest","color":"gold","italic":false}',Lore:['{"text":"Places a TNT Trapped chect at your position","color":"dark_aqua"}']},CustomModelData:110001, EntityTag:{Silent:1b, Tags:["trapped_chest_en"]}} 64`,

        `minecraft:barrier{display:{Name:'{"text":"Invisible Block","color":"gold","italic":false}',Lore:['{"text":"Places invisible block at your position","color":"dark_aqua"}']}} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Instant Hole","color":"gold","italic":false}',Lore:['{"text":"Dig 3x3 hole at your position","color":"dark_aqua"}']},CustomModelData:110007} 1`,

        `coarse_dirt{display:{Name:'{"text":"Block of Diamond","italic":false}'}} 64`,

        `chest{display:{Name:'{"text":"Useless Chest", "italic":false}'},BlockEntityTag:{LootTable:"minecraft:chests/useless_chest"}} 64`,
        
        `carrot_on_a_stick{display:{Name:'{"text":"Hidden Trampoline","color":"gold","italic":false}',Lore:['{"text":"Places a invisible trampoline at your position","color":"dark_aqua"}']},CustomModelData:110008} 1`,

        `iron_door{display:{Name:'{"text":"Locked Door","italic":false}'}} 64`,

        `endermite_spawn_egg{display:{Name:'{"text":"Creeper Hole","color":"gold","italic":false}',Lore:['{"text":"Places a creeper hole at your position","color":"dark_aqua"}']},CustomModelData:110002, EntityTag:{Silent:1b, Tags:["creeper_hole_en"]}} 64`,

        `fishing_rod{display:{Name:'{"text":"Troll Rod","color":"gold","italic":false}',Lore:['{"text":"Grab a player with it and push them","color":"dark_aqua"}']}} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Fire Trap","color":"gold","italic":false}',Lore:['{"text":"Places array of fire at your position","color":"dark_aqua"}']},CustomModelData:110010} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Spider Trap","color":"gold","italic":false}',Lore:['{"text":"Summons spider at the closest player location","color":"dark_aqua"}']},CustomModelData:110011} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Teleport To Closest Player","color":"gold","italic":false}',Lore:['{"text":"Teleports you to the closest player","color":"dark_aqua"}']},CustomModelData:110012} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Firework Trap","color":"gold","italic":false}',Lore:['{"text":"Summons fireworks at the closest player location","color":"dark_aqua"}']},CustomModelData:110013} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Change Speed","color":"gold","italic":false}',Lore:['{"text":"Change the speed of the player you are looking at and click right click","color":"dark_aqua"}']},CustomModelData:110014} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Creeper Rain","color":"gold","italic":false}',Lore:['{"text":"Raining creeper around player you are looking at and click right click","color":"dark_aqua"}']},CustomModelData:110015} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Clear Item","color":"gold","italic":false}',Lore:['{"text":"Clear the main item from the player you are looking at and click right click","color":"dark_aqua"}']},CustomModelData:110016} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Block Destructor","color":"gold","italic":false}',Lore:['{"text":"Destroy every block at the feet of the player you are looking at and click right click (For 15 Seconds)","color":"dark_aqua"}']},CustomModelData:110017} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Covert to Lava","color":"gold","italic":false}',Lore:['{"text":"Convert all the blocks to lava at the player you are looking at and click right click","color":"dark_aqua"}']},CustomModelData:110018} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Covert Village","color":"gold","italic":false}',Lore:['{"text":"Convert the village you are in into a nightmare village","color":"dark_aqua"}']},CustomModelData:110019} 1`,

        `carrot_on_a_stick{display:{Name:'{"text":"Random Teleport","color":"gold","italic":false}',Lore:['{"text":"Randomly teleport the player(s)","color":"dark_aqua"}']},CustomModelData:110020} 1`
    ]
    storage.set("ITEMS_LENGTH", items.length)
    storage.set("ITEMS", items)
    console.log(storage.get("ITEMS_LENGTH") - 8) + 1
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