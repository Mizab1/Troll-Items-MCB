function tick{
    execute as @e[type=experience_orb, tag=!checked] at @s if entity @a[distance=..3] run{
        execute store result entity @s Value int 7 run data get entity @s Value
        tag @s add checked
    }
}