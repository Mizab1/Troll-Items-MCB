#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard players set #execute LANG_MC_INTERNAL 0
execute if block ~ ~-0.35 ~ minecraft:grass_block run function troll_items:__generated__/conditional/0
execute if score #execute LANG_MC_INTERNAL matches 0 if block ~ ~-0.35 ~ minecraft:stone run function troll_items:__generated__/conditional/1
execute if score #execute LANG_MC_INTERNAL matches 0 run function troll_items:__generated__/conditional/2