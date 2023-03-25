#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard objectives add rc_detect minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add item_select dummy
scoreboard objectives add LANG_MC_INTERNAL dummy
gamerule keepInventory true
gamerule doDaylightCycle false
gamerule doWeatherCycle false
gamerule commandModificationBlockLimit 999999999
forceload add 100 100