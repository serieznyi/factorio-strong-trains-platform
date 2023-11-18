local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

---@param type string
---@param rolling_stock_type string
---@return table
local function get_strong_minimap_representation(type, rolling_stock_type)
    return {
       filename = "__StrongTrainsPlatform__/graphics/entity/" .. type .. "/" .. rolling_stock_type .. "/minimap-representation/default.png",
       flags = {"icon"},
       size = {20, 40},
       scale = 0.5
   }
end

---@param type string
---@param rolling_stock_type string
---@return table
local function get_strong_minimap_representation_selected(type, rolling_stock_type)
    return {
       filename = "__StrongTrainsPlatform__/graphics/entity/" .. type .. "/" .. rolling_stock_type .. "/minimap-representation/selected.png",
       flags = {"icon"},
       size = {20, 40},
       scale = 0.5
   }
end

local prototype_defines = require("defines")
local platform_pictures = {
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
                "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/body/cargo-wagon-1.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/body/cargo-wagon-2.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/body/cargo-wagon-3.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/body/cargo-wagon-4.png"
            },
            line_length = 4,
            lines_per_file = 8,
            shift = {0, -0.55},
            scale = 1.0,
        },
        {
            flags = { "shadow" },
            priority = "very-low",
            dice = 4,
            width = 300,
            height = 300,
            back_equals_front = true,
            draw_as_shadow = true,
            direction_count = 128,
            allow_low_quality_rotation = true,
            filenames =
            {
                "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/shadows/shadow-1.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/shadows/shadow-2.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/shadows/shadow-3.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/shadows/shadow-4.png",
            },
            line_length = 4,
            lines_per_file = 8,
            shift = {0, -0.55},
        }
    }
}
local destroyed_health_size = 300000
local destroyed_resistance = {
    {type = "physical", percent = 85},
    {type = "explosion",  percent = 85},
    {type = "acid", percent = 85},
    {type = "fire", percent = 85},
    {type = "impact", percent = 85}
}
local prototypes = {}
local prototype
local original_prototype

------------- PROTOTYPE: Destroyed Locomotive
original_prototype = data.raw["locomotive"]["locomotive"]

prototype = table.deepcopy(original_prototype)
prototype.name = prototype_defines.entity.destroyed_locomotive
prototype.minable = {mining_time = 0.5, result = prototype_defines.item.destroyed_locomotive} -- destroyed: get own item
prototype.placeable_by = {item = prototype_defines.item.destroyed_locomotive, count = 1} -- destroyed: define own placeable
prototype.create_ghost_on_death = false
prototype.max_health = destroyed_health_size -- destroyed: make almost invulnerable
prototype.weight = original_prototype.weight * 0.5
prototype.max_speed = original_prototype.max_speed * 0.75
prototype.max_power = "450kW" -- destroyed: 75% from original locomotive
prototype.reversing_power_modifier = original_prototype.reversing_power_modifier * 0.75
prototype.resistances = destroyed_resistance -- destroyed: use high resistance for all
prototype.is_military_target = false
prototype.burner = {
    fuel_category = "chemical",
    effectivity = original_prototype.burner.effectivity * 0.75,
    fuel_inventory_size = 1, -- destroyed: only one slot for fuel
    smoke =
    {
        {
            name = "train-smoke",
            deviation = {0.0, 0.0},
            frequency = 25,
            position = {0.5, -3.0},
            starting_frame = 0,
            starting_frame_deviation = 60,
            height = 0.15,
            height_deviation = 0.1,
            starting_vertical_speed = 0.05,
            starting_vertical_speed_deviation = 0.1
        }
    }
}
prototype.front_light = nil -- destroyed: disabled
prototype.back_light = nil -- destroyed: disabled
prototype.stand_by_light = nil -- destroyed: disabled
prototype.allow_passengers = false -- destroyed: no passenger
prototype.pictures = { -- destroyed: use pictures for destroyed
    layers =
    {
        {
            dice = 4,
            priority = "very-low",
            width = 300,
            height = 300,
            direction_count = 256,
            allow_low_quality_rotation = true,
            filenames =
            {
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/body/locomotive-1.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/body/locomotive-2.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/body/locomotive-3.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/body/locomotive-4.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/body/locomotive-5.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/body/locomotive-6.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/body/locomotive-7.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/body/locomotive-8.png"
            },
            line_length = 4,
            lines_per_file = 8,
            shift = {0, -0.55},
            scale = 1.0,
        },
        {
            priority = "very-low",
            dice = 4,
            flags = { "shadow" },
            width = 300,
            height = 300,
            direction_count = 256,
            draw_as_shadow = true,
            allow_low_quality_rotation = true,
            filenames =
            {
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/shadows/shadow-1.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/shadows/shadow-2.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/shadows/shadow-3.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/shadows/shadow-4.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/shadows/shadow-5.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/shadows/shadow-6.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/shadows/shadow-7.png",
                "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/shadows/shadow-8.png"
            },
            line_length = 4,
            lines_per_file = 8,
            shift = {0, -0.55},
            scale = 1.0,
        }
    }
}
prototype.front_light_pictures = nil -- destroyed: disabled
prototype.minimap_representation = get_strong_minimap_representation("destroyed", "locomotive")
prototype.selected_minimap_representation = get_strong_minimap_representation_selected("destroyed", "locomotive")
table.insert(prototypes, prototype)

------------- PROTOTYPE: Destroyed Wagon
original_prototype = data.raw["cargo-wagon"]["cargo-wagon"]

prototype = table.deepcopy(original_prototype)
prototype.name = prototype_defines.entity.destroyed_cargo_wagon
prototype.inventory_size = 0 -- destroyed: no cargo
prototype.minable = {mining_time = 0.5, result = prototype_defines.item.destroyed_cargo_wagon}
prototype.max_health = destroyed_health_size -- destroyed: make almost invulnerable
prototype.weight = original_prototype.weight * 0.5
prototype.max_speed = original_prototype.max_speed * 0.75
prototype.resistances = destroyed_resistance
prototype.is_military_target = false
prototype.back_light = nil -- destroyed: no additional animation
prototype.stand_by_light = nil -- destroyed: no additional animation
prototype.pictures = platform_pictures -- destroyed: one set animation for all types wagons
prototype.horizontal_doors = nil -- destroyed: no additional animation
prototype.vertical_doors = nil -- destroyed: no additional animation
prototype.minimap_representation = {
    filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/minimap-representation/default.png",
    flags = {"icon"},
    size = {20, 40},
    scale = 0.5
} -- destoyed: use own representation icons
prototype.selected_minimap_representation = {
    filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/minimap-representation/selected.png",
    flags = {"icon"},
    size = {20, 40},
    scale = 0.5
} -- destoyed: use own representation icons
prototype.open_sound = nil -- destroyed: no additional sounds
prototype.close_sound = nil -- destroyed: no additional sounds
prototype.create_ghost_on_death = false
prototype.allow_passengers = false -- destroyed: no place for passengers
prototype.placeable_by = {item = prototype_defines.item.destroyed_cargo_wagon, count = 1}
prototype.minimap_representation = get_strong_minimap_representation("destroyed", "cargo-wagon")
prototype.selected_minimap_representation = get_strong_minimap_representation_selected("destroyed", "cargo-wagon")
table.insert(prototypes, prototype)

------------- PROTOTYPE: Destroyed Fluid Wagon
original_prototype = data.raw["fluid-wagon"]["fluid-wagon"]

prototype = table.deepcopy(original_prototype)
prototype.name = prototype_defines.entity.destroyed_fluid_wagon
prototype.minable = {mining_time = 0.5, result = prototype_defines.item.destroyed_fluid_wagon}
prototype.mined_sound = {filename = "__core__/sound/deconstruct-large.ogg",volume = 0.8}
prototype.max_health = destroyed_health_size
prototype.capacity = 0
prototype.weight = original_prototype.weight * 0.5
prototype.max_speed = original_prototype.max_speed * 0.75
prototype.resistances = destroyed_resistance
prototype.is_military_target = false
prototype.back_light = nil
prototype.stand_by_light = nil
prototype.pictures = platform_pictures
prototype.minimap_representation = get_strong_minimap_representation("destroyed", "fluid-wagon")
prototype.selected_minimap_representation = get_strong_minimap_representation_selected("destroyed", "fluid-wagon")
table.insert(prototypes, prototype)

------------- PROTOTYPE: Destroyed Artillery Wagon
original_prototype = data.raw["artillery-wagon"]["artillery-wagon"]

prototype = table.deepcopy(data.raw["artillery-wagon"]["artillery-wagon"])
prototype.name = prototype_defines.entity.destroyed_artillery_wagon
prototype.inventory_size = 1
prototype.minable = {mining_time = 0.5, result = prototype_defines.item.destroyed_artillery_wagon}
prototype.max_health = destroyed_health_size
prototype.weight = original_prototype.weight * 0.5
prototype.max_speed = original_prototype.max_speed * 0.75
prototype.resistances = destroyed_resistance
prototype.is_military_target = false
prototype.back_light = nil
prototype.stand_by_light = nil
prototype.pictures = platform_pictures
prototype.cannon_barrel_pictures = nil
prototype.cannon_base_pictures = nil
prototype.minimap_representation = get_strong_minimap_representation("destroyed", "artillery-wagon")
prototype.selected_minimap_representation = get_strong_minimap_representation_selected("destroyed", "artillery-wagon")
prototype.open_sound = nil
prototype.close_sound = nil
prototype.rotating_sound = nil
prototype.rotating_stopped_sound = nil
prototype.cannon_base_shiftings = nil
table.insert(prototypes, prototype)

------------- PROTOTYPE: Strong Cargo Wagon
prototype = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
prototype.name = prototype_defines.entity.strong_cargo_wagon
prototype.minable.result = prototype_defines.item.strong_cargo_wagon
prototype.minimap_representation = get_strong_minimap_representation("strong", "cargo-wagon")
prototype.selected_minimap_representation = get_strong_minimap_representation_selected("strong", "cargo-wagon")
table.insert(prototypes, prototype)

------------- PROTOTYPE: Strong Fluid Wagon
prototype = table.deepcopy(data.raw["fluid-wagon"]["fluid-wagon"])
prototype.name = prototype_defines.entity.strong_fluid_wagon
prototype.minable.result = prototype_defines.item.strong_fluid_wagon
prototype.minimap_representation = get_strong_minimap_representation("strong", "fluid-wagon")
prototype.selected_minimap_representation = get_strong_minimap_representation_selected("strong", "fluid-wagon")
table.insert(prototypes, prototype)

------------- PROTOTYPE: Strong Artillery Wagon
prototype = table.deepcopy(data.raw["artillery-wagon"]["artillery-wagon"])
prototype.name = prototype_defines.entity.strong_artillery_wagon
prototype.minable.result = prototype_defines.item.strong_artillery_wagon
prototype.minimap_representation = get_strong_minimap_representation("strong", "artillery-wagon")
prototype.selected_minimap_representation = get_strong_minimap_representation_selected("strong", "artillery-wagon")
table.insert(prototypes, prototype)

------------- PROTOTYPE: Strong Locomotive
prototype = table.deepcopy(data.raw["locomotive"]["locomotive"])
prototype.name = prototype_defines.entity.strong_locomotive
prototype.minable.result = prototype_defines.item.strong_locomotive
prototype.minimap_representation = get_strong_minimap_representation("strong", "locomotive")
prototype.selected_minimap_representation = get_strong_minimap_representation_selected("strong", "locomotive")
table.insert(prototypes, prototype)

data:extend(prototypes)