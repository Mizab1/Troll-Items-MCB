#built using mc-build (https://github.com/mc-build/mc-build)

execute if block ~ ~ ~ air unless entity @e[type=!player,dx=0] positioned ^ ^ ^1 run function troll_items:__generated__/execute/25
execute as @a[tag=!troller, dx=0] at @s run effect give @s speed 15 100 true