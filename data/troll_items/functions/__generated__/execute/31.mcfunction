#built using mc-build (https://github.com/mc-build/mc-build)

execute if block ~ ~ ~ air unless entity @e[type=!player,dx=0] positioned ^ ^ ^1 run function troll_items:__generated__/execute/31
execute as @a[tag=!troller, dx=0] at @s run item replace entity @s weapon.mainhand with air