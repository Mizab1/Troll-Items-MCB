#built using mc-build (https://github.com/mc-build/mc-build)

execute as @a[tag=!troller, limit=1, sort=nearest] at @s run function troll_items:drop_item_from_mainhand
tellraw @s {"text":"You made the person to drop their item", "color":"gold"}