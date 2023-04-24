local function minimap_representation(filename)
    return {
        filename = filename,
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    }
end

local empty_icon_path = "__TrainsStrongPlatform__/graphics/entity/empty.png"
local prototype_defines = require("defines.index")
local prototype = nil

------------- PROTOTYPE: Destroyed Locomotive
prototype = table.deepcopy(data.raw["locomotive"]["locomotive"])
prototype.name = prototype_defines.entity.destroyed_locomotive
prototype.max_health = 30000
prototype.corpse = "locomotive-remnants"
prototype.max_speed = 0.6
prototype.max_power = "300kW"
prototype.burner = {
    type = "burner",
    fuel_inventory_size = 1,
    effectivity = 0.5,
}
prototype.minable = { mining_time = 1, result = prototype_defines.item.destroyed_locomotive }
prototype.placeable_by = {item = prototype_defines.item.destroyed_locomotive, count = 1}
prototype.create_ghost_on_death = false
--prototype.max_speed =
prototype.pictures = {size = {1, 1}, filename = empty_icon_path, direction_count = 1}
prototype.selected_minimap_representation = minimap_representation("__TrainsStrongPlatform__/graphics/entity/destroyed-locomotive/minimap-representation/selected.png")
prototype.minimap_representation = minimap_representation("__TrainsStrongPlatform__/graphics/entity/destroyed-locomotive/minimap-representation/default.png")
prototype.resistances = {
    {type = "physical", percent = 85},
    {type = "explosion",  percent = 85},
    {type = "acid", percent = 85},
    {type = "fire", percent = 85},
    {type = "impact", percent = 85}
}
prototype.weight = 1000
prototype.allow_passengers = false

data:extend({prototype})

------------- PROTOTYPE: Destroyed Platform
prototype = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
prototype.name = prototype_defines.entity.destroyed_platform
prototype.max_health = 30000
prototype.corpse = "cargo-wagon-remnants"
prototype.minable = { mining_time = 1, result = prototype_defines.item.destroyed_platform }
prototype.placeable_by = {item = prototype_defines.item.destroyed_platform, count = 1}
prototype.create_ghost_on_death = false
prototype.horizontal_doors = nil
prototype.vertical_doors = nil
prototype.inventory_size = 0
prototype.pictures =
{
    layers =
    {
        {
            priority = "very-low",
            dice = 4,
            width = 300,
            height = 300,
            back_equals_front = true,
            direction_count = 128,
            allow_low_quality_rotation = true,
            filenames =
            {
                "__TrainsStrongPlatform__/graphics/entity/destroyed-platform/destroyed-platform-1.png",
                "__TrainsStrongPlatform__/graphics/entity/destroyed-platform/destroyed-platform-2.png",
                "__TrainsStrongPlatform__/graphics/entity/destroyed-platform/destroyed-platform-3.png",
                "__TrainsStrongPlatform__/graphics/entity/destroyed-platform/destroyed-platform-4.png"
            },
            line_length = 4,
            lines_per_file = 8,
            shift = {0, -0.5},
            scale = 1.0,
            --hr_version =
            --{
            --    priority = "very-low",
            --    dice = 4,
            --    width = 442,
            --    height = 407,
            --    back_equals_front = true,
            --    direction_count = 128,
            --    allow_low_quality_rotation = true,
            --    filenames =
            --    {
            --        "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-1.png",
            --        "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-2.png",
            --        "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-3.png",
            --        "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-4.png"
            --    },
            --    line_length = 4,
            --    lines_per_file = 8,
            --    shift = util.by_pixel(0, -25.25),
            --    scale = 0.5
            --}
        },
        --{
        --    flags = { "mask" },
        --    priority = "very-low",
        --    dice = 4,
        --    width = 196,
        --    height = 174,
        --    direction_count = 128,
        --    allow_low_quality_rotation = true,
        --    back_equals_front = true,
        --    apply_runtime_tint = true,
        --    shift = {0, -1.125},
        --    filenames =
        --    {
        --        "__base__/graphics/entity/cargo-wagon/cargo-wagon-mask-1.png",
        --        "__base__/graphics/entity/cargo-wagon/cargo-wagon-mask-2.png",
        --        "__base__/graphics/entity/cargo-wagon/cargo-wagon-mask-3.png"
        --    },
        --    line_length = 4,
        --    lines_per_file = 11,
        --    hr_version =
        --    {
        --        flags = { "mask" },
        --        priority = "very-low",
        --        dice = 4,
        --        width = 406,
        --        height = 371,
        --        direction_count = 128,
        --        allow_low_quality_rotation = true,
        --        back_equals_front = true,
        --        apply_runtime_tint = true,
        --        shift = util.by_pixel(-0.5, -30.25),
        --        filenames =
        --        {
        --            "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-mask-1.png",
        --            "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-mask-2.png",
        --            "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-mask-3.png"
        --        },
        --        line_length = 4,
        --        lines_per_file = 11,
        --        scale = 0.5
        --    }
        --},
        --{
        --    flags = { "shadow" },
        --    priority = "very-low",
        --    dice = 4,
        --    width = 246,
        --    height = 201,
        --    back_equals_front = true,
        --    draw_as_shadow = true,
        --    direction_count = 128,
        --    allow_low_quality_rotation = true,
        --    filenames =
        --    {
        --        "__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow-1.png",
        --        "__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow-2.png",
        --        "__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow-3.png",
        --        "__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow-4.png"
        --    },
        --    line_length = 4,
        --    lines_per_file = 8,
        --    shift = {0.8, -0.078125},
        --    hr_version =
        --    {
        --        flags = { "shadow" },
        --        priority = "very-low",
        --        dice = 4,
        --        width = 490,
        --        height = 401,
        --        back_equals_front = true,
        --        draw_as_shadow = true,
        --        direction_count = 128,
        --        allow_low_quality_rotation = true,
        --        filenames =
        --        {
        --            "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-shadow-1.png",
        --            "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-shadow-2.png",
        --            "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-shadow-3.png",
        --            "__base__/graphics/entity/cargo-wagon/hr-cargo-wagon-shadow-4.png"
        --        },
        --        line_length = 4,
        --        lines_per_file = 8,
        --        shift = util.by_pixel(32, -2.25),
        --        scale = 0.5
        --    }
        --}
    }
}
prototype.minimap_representation = minimap_representation("__TrainsStrongPlatform__/graphics/entity/destroyed-platform/minimap-representation/default.png")
prototype.selected_minimap_representation = minimap_representation("__TrainsStrongPlatform__/graphics/entity/destroyed-platform/minimap-representation/selected.png")
prototype.resistances = {
    {type = "physical", percent = 85},
    {type = "explosion",  percent = 85},
    {type = "acid", percent = 85},
    {type = "fire", percent = 85},
    {type = "impact", percent = 85}
}
prototype.weight = 500
prototype.allow_passengers = false

data:extend({prototype})