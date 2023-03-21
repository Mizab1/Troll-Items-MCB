#built using mc-build (https://github.com/mc-build/mc-build)

execute at @a[tag=!troller, limit=1, sort=nearest] run fill ~-1 ~-20 ~-1 ~1 ~ ~1 minecraft:air
tellraw @s {"text":"You digged a hole at your victim's position", "color":"gold"}