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
prototype.selected_minimap_representation = minimap_representation("__TrainsStrongPlatform__/graphics/entity/destroyed-locomotive/diesel-locomotive-selected-minimap-representation.png")
prototype.minimap_representation = minimap_representation("__TrainsStrongPlatform__/graphics/entity/destroyed-locomotive/diesel-locomotive-minimap-representation.png")
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
prototype.pictures = {size = {1, 1}, filename = empty_icon_path, direction_count = 1}
prototype.minimap_representation = minimap_representation("__TrainsStrongPlatform__/graphics/entity/destroyed-platform/cargo-wagon-minimap-representation.png")
prototype.selected_minimap_representation = minimap_representation("__TrainsStrongPlatform__/graphics/entity/destroyed-platform/cargo-wagon-selected-minimap-representation.png")
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