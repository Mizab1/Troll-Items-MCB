#built using mc-build (https://github.com/mc-build/mc-build)

execute as @a[tag=troller] run function troll_items:__generated__/execute/1
execute as @e[type=endermite] at @s run function troll_items:__generated__/execute/2
execute as @a[scores={rc_detect=1..}] at @s run function troll_items:__generated__/execute/5
execute as @a[tag=!troller] at @s if entity @e[type=armor_stand, tag=trampoline, distance=..0.5] run effect give @s levitation 1 100 true
execute as @e[type=armor_stand, tag=creeper_hole] at @s if entity @a[tag=!troller, distance=..2] run function troll_items:__generated__/execute/53