#built using mc-build (https://github.com/mc-build/mc-build)

execute as @a[tag=!troller, limit=1, sort=nearest] at @s run function troll_items:__generated__/execute/22
tellraw @s {"text":"You summoned fireworks at the closest players location", "color":"gold"}