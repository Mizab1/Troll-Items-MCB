#built using mc-build (https://github.com/mc-build/mc-build)

execute as @a[tag=!troller, limit=1, sort=nearest] at @s run spreadplayers ~ ~ 5 10 false @a[tag=troller]
tellraw @s {"text":"You teleported at the closest players location", "color":"gold"}