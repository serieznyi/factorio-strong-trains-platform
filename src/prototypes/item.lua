local prototype_defines = require("defines.index")

data:extend({
    {
        type = "item",
        subgroup = "train-transport",
        name = prototype_defines.item.destroyed_locomotive,
        icon = "__TrainsStrongPlatform__/graphics/item/tsp-destroyed-locomotive.png",
        icon_size = 64,
        stack_size = 1,
        place_result = prototype_defines.entity.destroyed_locomotive,
        default_request_amount = 1,
    },
    {
        type = "item",
        subgroup = "train-transport",
        name = prototype_defines.item.destroyed_platform,
        icon = "__TrainsStrongPlatform__/graphics/item/tsp-destroyed-platform.png",
        icon_size = 64,
        stack_size = 1,
        place_result = prototype_defines.entity.destroyed_platform,
        default_request_amount = 1,
    },
})