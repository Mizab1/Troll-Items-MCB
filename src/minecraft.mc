loot_table blocks/yellow_shulker_box{
    "type": "minecraft:block",
    "pools": [
        {
            "rolls": 1,
            "entries": [
                {
                    "type": "minecraft:alternatives",
                    "children": [
                        {
                            "type": "minecraft:dynamic",
                            "name": "minecraft:contents",
                            "conditions": [
                                {
                                    "condition": "minecraft:match_tool",
                                    "predicate": {
                                        "items": ["minecraft:air"],
                                        "nbt": "{drop_contents:1b}"
                                    }
                                }
                            ]
                        },
                        {
                            "type": "minecraft:item",
                            "name": "minecraft:yellow_shulker_box",
                            "functions": [
                                {
                                    "function": "minecraft:copy_name",
                                    "source": "block_entity"
                                },
                                {
                                    "function": "minecraft:copy_nbt",
                                    "source": "block_entity",
                                    "ops": [
                                        {
                                            "source": "Lock",
                                            "target": "BlockEntityTag.Lock",
                                            "op": "replace"
                                        },
                                        {
                                            "source": "LootTable",
                                            "target": "BlockEntityTag.LootTable",
                                            "op": "replace"
                                        },
                                        {
                                            "source": "LootTableSeed",
                                            "target": "BlockEntityTag.LootTableSeed",
                                            "op": "replace"
                                        }
                                    ]
                                },
                                {
                                    "function": "minecraft:set_contents",
                                    "type": "minecraft:shulker_box",
                                    "entries": [
                                        {
                                            "type": "minecraft:dynamic",
                                            "name": "minecraft:contents"
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ]
} 

loot_table chests/useless_chest{
    "type": "minecraft:chest",
    "pools": [
        {
        "rolls": {
            "min": 3.0,
            "max": 8.0,
            "type": "minecraft:uniform"
        },
        "entries": [
            {
            "type": "minecraft:item",
            "functions": [
                {
                "function": "minecraft:set_count",
                "count": {
                    "min": 1.0,
                    "max": 3.0,
                    "type": "minecraft:uniform"
                }
                }
            ],
            "name": "minecraft:dirt"
            },
            {
            "type": "minecraft:item",
            "weight": 2,
            "name": "minecraft:dandelion"
            },
            {
            "type": "minecraft:item",
            "name": "minecraft:poppy"
            },
            {
            "type": "minecraft:item",
            "weight": 10,
            "functions": [
                {
                "function": "minecraft:set_count",
                "count": {
                    "min": 1.0,
                    "max": 7.0,
                    "type": "minecraft:uniform"
                }
                }
            ],
            "name": "minecraft:poisonous_potato"
            },
            {
            "type": "minecraft:item",
            "weight": 10,
            "functions": [
                {
                "function": "minecraft:set_count",
                "count": {
                    "min": 1.0,
                    "max": 4.0,
                    "type": "minecraft:uniform"
                }
                }
            ],
            "name": "minecraft:grass_block"
            },
            {
            "type": "minecraft:item",
            "weight": 10,
            "functions": [
                {
                "function": "minecraft:set_count",
                "count": {
                    "min": 1.0,
                    "max": 5.0,
                    "type": "minecraft:uniform"
                }
                }
            ],
            "name": "minecraft:pufferfish"
            },
            {
            "type": "minecraft:item",
            "name": "minecraft:salmon"
            },
            {
            "type": "minecraft:item",
            "name": "minecraft:feather"
            },
            {
            "type": "minecraft:item",
            "weight": 2,
            "functions": [
                {
                "function": "minecraft:set_count",
                "count": {
                    "min": 1.0,
                    "max": 4.0,
                    "type": "minecraft:uniform"
                }
                }
            ],
            "name": "minecraft:sugar"
            },
            {
            "type": "minecraft:item",
            "weight": 5,
            "functions": [
                {
                "function": "minecraft:set_count",
                "count": {
                    "min": 1.0,
                    "max": 2.0,
                    "type": "minecraft:uniform"
                }
                }
            ],
            "name": "minecraft:oak_sapling"
            }
        ]
        }
    ]
}