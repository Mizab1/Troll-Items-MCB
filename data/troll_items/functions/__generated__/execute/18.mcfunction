#built using mc-build (https://github.com/mc-build/mc-build)

execute at @a[tag=!troller, limit=1, sort=nearest] run function troll_items:__generated__/execute/19
tellraw @s {"text":"You summoned spiders at the closest players location", "color":"gold"}