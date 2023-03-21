#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~ ~ {Marker:1b,Invisible:1b,Tags:["trampoline"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:100001}}]}
tellraw @s {"text":"You placed hidden trampoline at you position", "color":"gold"}