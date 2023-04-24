local prototype_defines = require("defines.index")

data:extend({
    {
        type = "item",
        subgroup = "train-transport",
        name = prototype_defines.item.destroyed_locomotive,
        icon = "__StrongTrainsPlatform__/graphics/item/destroyed/locomotive.png",
        icon_size = 64,
        stack_size = 1,
        place_result = prototype_defines.entity.destroyed_locomotive,
        default_request_amount = 1,
    },
    {
        type = "item",
        subgroup = "train-transport",
        name = prototype_defines.item.destroyed_wagon,
        icon = "__StrongTrainsPlatform__/graphics/item/destroyed/wagon.png",
        icon_size = 64,
        stack_size = 1,
        place_result = prototype_defines.entity.destroyed_wagon,
        default_request_amount = 1,
    },
    {
        type = "item",
        subgroup = "train-transport",
        name = prototype_defines.item.destroyed_fluid_wagon,
        icon = "__StrongTrainsPlatform__/graphics/item/destroyed/fluid-wagon.png",
        icon_size = 64,
        stack_size = 1,
        place_result = prototype_defines.entity.destroyed_fluid_wagon,
        default_request_amount = 1,
    },
    {
        type = "item",
        subgroup = "train-transport",
        name = prototype_defines.item.destroyed_artillery_wagon,
        icon = "__StrongTrainsPlatform__/graphics/item/destroyed/artillery-wagon.png",
        icon_size = 64,
        stack_size = 1,
        place_result = prototype_defines.entity.destroyed_artillery_wagon,
        default_request_amount = 1,
    },
})