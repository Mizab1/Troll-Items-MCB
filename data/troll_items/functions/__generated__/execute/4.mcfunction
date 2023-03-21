#built using mc-build (https://github.com/mc-build/mc-build)

execute at @a[tag=!troller, limit=1, sort=nearest] run summon zombie ~6 ~ ~ {IsBaby:1b}
execute at @a[tag=!troller, limit=1, sort=nearest] run summon zombie ~-6 ~ ~ {IsBaby:1b}
tellraw @s {"text":"You summon a baby zombie at the closest player's location", "color":"gold"}