local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local prototype_defines = require("defines.index")
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
local destroyed_health_size = 30000
local destroyed_resistance = {
    {type = "physical", percent = 85},
    {type = "explosion",  percent = 85},
    {type = "acid", percent = 85},
    {type = "fire", percent = 85},
    {type = "impact", percent = 85}
}
local destroyed_platform_weight = 200

------------- PROTOTYPE: Destroyed Locomotive
local locomotive = {
    name = prototype_defines.entity.destroyed_locomotive,
    -------------------------------------------------------------------------------------------------------------------
    ------                        DEFAULT VALUES
    -------------------------------------------------------------------------------------------------------------------
    type = "locomotive",
    icon = "__base__/graphics/icons/locomotive.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    mined_sound = {filename = "__core__/sound/deconstruct-large.ogg", volume = 0.8},
    corpse = "locomotive-remnants",
    dying_explosion = "locomotive-explosion",
    collision_box = {{-0.6, -2.6}, {0.6, 2.6}},
    selection_box = {{-1, -3}, {1, 3}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1, -4}, {1, 3}},
    alert_icon_shift = util.by_pixel(0, -24),
    braking_force = 10,
    friction_force = 0.50,
    vertical_selection_shift = -0.5,
    air_resistance = 0.0075, -- this is a percentage of current speed that will be subtracted
    connection_distance = 3,
    joint_distance = 4,
    energy_per_hit_point = 5,
    color = {r = 0.92, g = 0.07, b = 0, a = 0.5},
    wheels = standard_train_wheels,
    stop_trigger =
    {
        -- left side
        {
            type = "create-trivial-smoke",
            repeat_count = 125,
            smoke_name = "smoke-train-stop",
            initial_height = 0,
            -- smoke goes to the left
            speed = {-0.03, 0},
            speed_multiplier = 0.75,
            speed_multiplier_deviation = 1.1,
            offset_deviation = {{-0.75, -2.7}, {-0.3, 2.7}}
        },
        -- right side
        {
            type = "create-trivial-smoke",
            repeat_count = 125,
            smoke_name = "smoke-train-stop",
            initial_height = 0,
            -- smoke goes to the right
            speed = {0.03, 0},
            speed_multiplier = 0.75,
            speed_multiplier_deviation = 1.1,
            offset_deviation = {{0.3, -2.7}, {0.75, 2.7}}
        },
        {
            type = "play-sound",
            sound = sounds.train_brakes
        },
        {
            type = "play-sound",
            sound = sounds.train_brake_screech
        }
    },
    drive_over_tie_trigger = drive_over_tie(),
    tie_distance = 50,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
        sound =
        {
            filename = "__base__/sound/train-engine.ogg",
            volume = 0.35
        },
        deactivate_sound =
        {
            filename = "__base__/sound/train-engine-stop.ogg",
            volume = 0
        },
        match_speed_to_activity = true,
        max_sounds_per_type = 2,
        -- use_doppler_shift = false
    },
    open_sound = { filename = "__base__/sound/train-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/train-door-close.ogg", volume = 0.4 },
    sound_minimum_speed = 0.5,
    sound_scaling_ratio = 0.35,
    water_reflection = locomotive_reflection(),
    -------------------------------------------------------------------------------------------------------------------
    ------                        OVERRIDE VALUES
    -------------------------------------------------------------------------------------------------------------------
    minable = {mining_time = 0.5, result = prototype_defines.item.destroyed_locomotive}, -- destroyed: get own item
    placeable_by = {item = prototype_defines.item.destroyed_locomotive, count = 1}, -- destroyed: define own placeable
    create_ghost_on_death = false, -- destroyed: without ghost
    max_health = destroyed_health_size, -- destroyed: make almost invulnerable
    weight = 1000, -- destroyed: 50% from original locomotive
    max_speed = 0.6, -- destroyed: 50% from original locomotive
    max_power = "300kW", -- destroyed: 50% from original locomotive
    reversing_power_modifier = 0.3, -- destroyed: 50% from original locomotive
    resistances = destroyed_resistance, -- destroyed: use high resistance for all
    burner = {
        fuel_category = "chemical",
        effectivity = 0.5, -- destroyed: 50% from original locomotive
        fuel_inventory_size = 1, -- destroyed: only one slot for fuel
        smoke =
        {
            {
                name = "train-smoke",
                deviation = {0.3, 0.3},
                frequency = 100,
                position = {0, 0},
                starting_frame = 0,
                starting_frame_deviation = 60,
                height = 2,
                height_deviation = 0.5,
                starting_vertical_speed = 0.2,
                starting_vertical_speed_deviation = 0.1
            }
        }
    },
    front_light = nil, -- destroyed: disabled
    back_light = nil, -- destroyed: disabled
    stand_by_light = nil, -- destroyed: disabled
    allow_passengers = false, -- destroyed: no passenger
    pictures = { -- destroyed: use pictures for destroyed
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
    },
    front_light_pictures = nil, -- destroyed: disabled
    minimap_representation = {
        filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/minimap-representation/default.png",
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    }, -- destroyed: use own representation icons
    selected_minimap_representation = {
        filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/locomotive/minimap-representation/selected.png",
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    }, -- destroyed: use own representation icons
}

------------- PROTOTYPE: Destroyed Wagon
local cargo_wagon = {
    name = prototype_defines.entity.destroyed_wagon,
    -------------------------------------------------------------------------------------------------------------------
    ------                        DEFAULT VALUES
    -------------------------------------------------------------------------------------------------------------------
    type = "cargo-wagon",
    icon = "__base__/graphics/icons/cargo-wagon.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    mined_sound = {filename = "__core__/sound/deconstruct-large.ogg",volume = 0.8},
    corpse = "cargo-wagon-remnants",
    dying_explosion = "cargo-wagon-explosion",
    collision_box = {{-0.6, -2.4}, {0.6, 2.4}},
    selection_box = {{-1, -2.703125}, {1, 3.296875}},
    damaged_trigger_effect = hit_effects.entity(),
    vertical_selection_shift = -0.796875,
    braking_force = 3,
    friction_force = 0.50,
    air_resistance = 0.01,
    connection_distance = 3,
    joint_distance = 4,
    energy_per_hit_point = 5,
    color = {r = 0.43, g = 0.23, b = 0, a = 0.5},
    wheels = standard_train_wheels,
    drive_over_tie_trigger = drive_over_tie(),
    tie_distance = 50,
    working_sound =
    {
        sound =
        {
            filename = "__base__/sound/train-wheels.ogg",
            volume = 0.3
        },
        match_volume_to_activity = true
    },
    crash_trigger = crash_trigger(),
    sound_minimum_speed = 1,
    vehicle_impact_sound = sounds.generic_impact,
    water_reflection = locomotive_reflection(),

    -------------------------------------------------------------------------------------------------------------------
    ------                        OVERRIDE VALUES
    -------------------------------------------------------------------------------------------------------------------
    inventory_size = 0, -- destroyed: no cargo
    minable = {mining_time = 0.5, result = prototype_defines.item.destroyed_wagon},

    max_health = destroyed_health_size, -- destroyed: make almost invulnerable
    weight = 500, -- destroyed: 50% from original wagon
    max_speed = 0.75, -- destroyed: 50% from original wagon
    resistances = destroyed_resistance,
    back_light = nil, -- destroyed: no additional animation
    stand_by_light = nil, -- destroyed: no additional animation
    pictures = platform_pictures, -- destroyed: one set animation for all types wagons
    horizontal_doors = nil, -- destroyed: no additional animation
    vertical_doors = nil, -- destroyed: no additional animation
    minimap_representation =
    {
        filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/minimap-representation/default.png",
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    }, -- destoyed: use own representation icons
    selected_minimap_representation =
    {
        filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/cargo-wagon/minimap-representation/selected.png",
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    }, -- destoyed: use own representation icons
    open_sound = nil, -- destroyed: no additional sounds
    close_sound = nil, -- destroyed: no additional sounds
    create_ghost_on_death = false,
    allow_passengers = false, -- destroyed: no place for passengers
    placeable_by = {item = prototype_defines.item.destroyed_wagon, count = 1},
}

------------- PROTOTYPE: Destroyed Fluid Wagon
local fluid_wagon = {
    name = prototype_defines.entity.destroyed_fluid_wagon,
    -------------------------------------------------------------------------------------------------------------------
    ------                        DEFAULT VALUES
    -------------------------------------------------------------------------------------------------------------------
    type = "fluid-wagon",
    icon = "__base__/graphics/icons/fluid-wagon.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    corpse = "fluid-wagon-remnants",
    dying_explosion = "fluid-wagon-explosion",
    collision_box = {{-0.6, -2.4}, {0.6, 2.4}},
    selection_box = {{-1, -2.703125}, {1, 3.296875}},
    damaged_trigger_effect = hit_effects.entity(),
    vertical_selection_shift = -0.796875,
    braking_force = 3,
    friction_force = 0.50,
    air_resistance = 0.01,
    connection_distance = 3,
    joint_distance = 4,
    energy_per_hit_point = 6,
    color = {r = 0.43, g = 0.23, b = 0, a = 0.5},
    wheels = standard_train_wheels,
    drive_over_tie_trigger = drive_over_tie(),
    tie_distance = 50,
    working_sound =
    {
        sound =
        {
            filename = "__base__/sound/train-wheels.ogg",
            volume = 0.3
        },
        match_volume_to_activity = true
    },
    crash_trigger = crash_trigger(),
    sound_minimum_speed = 0.1,
    vehicle_impact_sound = sounds.generic_impact,
    water_reflection = locomotive_reflection(),
    -------------------------------------------------------------------------------------------------------------------
    ------                        OVERRIDE VALUES
    -------------------------------------------------------------------------------------------------------------------
    minable = {mining_time = 0.5, result = "fluid-wagon"},
    mined_sound = {filename = "__core__/sound/deconstruct-large.ogg",volume = 0.8},
    max_health = destroyed_health_size,
    capacity = 0,
    weight = destroyed_platform_weight,
    max_speed = 1.5,
    resistances = destroyed_resistance,
    back_light = nil,
    stand_by_light = nil,
    pictures = platform_pictures,
    minimap_representation =
    {
        filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/fluid-wagon/minimap-representation/default.png",
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    },
    selected_minimap_representation =
    {
        filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/fluid-wagon/minimap-representation/selected.png",
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    },
}
------------- PROTOTYPE: Destroyed Artillery Wagon

local artillery_wagon = {
    name = prototype_defines.entity.destroyed_artillery_wagon,
    -------------------------------------------------------------------------------------------------------------------
    ------                        DEFAULT VALUES
    -------------------------------------------------------------------------------------------------------------------
    type = "artillery-wagon",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    ammo_stack_limit = 100,
    corpse = "artillery-wagon-remnants",
    dying_explosion = "artillery-wagon-explosion",
    collision_box = {{-0.6, -2.4}, {0.6, 2.4}},
    selection_box = {{-1, -2.703125}, {1, 3.296875}},
    damaged_trigger_effect = hit_effects.entity(),
    vertical_selection_shift = -0.796875,
    braking_force = 3,
    friction_force = 0.50,
    air_resistance = 0.015,
    connection_distance = 3,
    joint_distance = 4,
    energy_per_hit_point = 2,
    gun = "artillery-wagon-cannon",
    turret_rotation_speed = 0.001,
    turn_after_shooting_cooldown = 60,
    cannon_parking_frame_count = 8,
    cannon_parking_speed = 0.25,
    manual_range_modifier = 2.5,
    mined_sound = {filename = "__core__/sound/deconstruct-large.ogg",volume = 0.8},
    color = {r = 0.43, g = 0.23, b = 0, a = 0.5},
    cannon_barrel_recoil_shiftings =
    {
        {x =-0.000, y =0.040, z =-0.000},
        {x =-0.789, y =0.037, z =-0.351},
        {x =-1.578, y =0.035, z =-0.702},
        {x =-2.367, y =0.033, z =-1.054},
        {x =-3.155, y =0.031, z =-1.405},
        {x =-3.944, y =0.028, z =-1.756},
        {x =-3.931, y =0.028, z =-1.750},
        {x =-3.901, y =0.028, z =-1.737},
        {x =-3.854, y =0.029, z =-1.716},
        {x =-3.790, y =0.029, z =-1.688},
        {x =-3.711, y =0.029, z =-1.652},
        {x =-3.617, y =0.029, z =-1.610},
        {x =-3.508, y =0.030, z =-1.562},
        {x =-3.385, y =0.030, z =-1.507},
        {x =-3.249, y =0.030, z =-1.447},
        {x =-3.102, y =0.031, z =-1.381},
        {x =-2.944, y =0.031, z =-1.311},
        {x =-2.776, y =0.032, z =-1.236},
        {x =-2.599, y =0.032, z =-1.157},
        {x =-2.416, y =0.033, z =-1.076},
        {x =-2.226, y =0.033, z =-0.991},
        {x =-2.032, y =0.034, z =-0.905},
        {x =-1.835, y =0.034, z =-0.817},
        {x =-1.635, y =0.035, z =-0.728},
        {x =-1.436, y =0.035, z =-0.639},
        {x =-1.238, y =0.036, z =-0.551},
        {x =-1.042, y =0.037, z =-0.464},
        {x =-0.851, y =0.037, z =-0.379},
        {x =-0.665, y =0.038, z =-0.296},
        {x =-0.485, y =0.038, z =-0.216},
        {x =-0.314, y =0.039, z =-0.140},
        {x =-0.152, y =0.039, z =-0.068}
    },
    cannon_barrel_light_direction = {0.5976251, 0.0242053, -0.8014102},
    cannon_barrel_recoil_shiftings_load_correction_matrix =
    {
        { 0,    0.25,   0 },
        {-0.25,    0,   0 },
        { 0,       0,   0.25 }
    },
    wheels = standard_train_wheels,
    drive_over_tie_trigger = drive_over_tie(),
    tie_distance = 50,
    working_sound =
    {
        sound =
        {
            filename = "__base__/sound/train-wheels.ogg",
            volume = 0.3
        },
        match_volume_to_activity = true
    },
    crash_trigger = crash_trigger(),
    sound_minimum_speed = 0.1,
    vehicle_impact_sound = sounds.generic_impact,
    water_reflection =
    {
        pictures =
        {
            filename = "__base__/graphics/entity/artillery-wagon/artillery-wagon-reflection.png",
            priority = "extra-high",
            width = 32,
            height = 52,
            shift = util.by_pixel(0, 40),
            variation_count = 1,
            scale = 5
        },
        rotate = true,
        orientation_to_variation = false
    },
    -------------------------------------------------------------------------------------------------------------------
    ------                        OVERRIDE VALUES
    -------------------------------------------------------------------------------------------------------------------
    icon = "__base__/graphics/icons/artillery-wagon.png",
    inventory_size = 1,
    minable = {mining_time = 0.5, result = prototype_defines.item.destroyed_artillery_wagon},
    max_health = destroyed_health_size,
    weight = destroyed_platform_weight,
    max_speed = 1.5,
    resistances = destroyed_resistance,
    back_light = nil,
    stand_by_light = nil,
    pictures = platform_pictures,
    cannon_barrel_pictures = nil,
    cannon_base_pictures = nil,
    minimap_representation =
    {
        filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/artillery-wagon/minimap-representation/default.png",
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    },
    selected_minimap_representation =
    {
        filename = "__StrongTrainsPlatform__/graphics/entity/destroyed/artillery-wagon/minimap-representation/selected.png",
        flags = {"icon"},
        size = {20, 40},
        scale = 0.5
    },
    open_sound = nil,
    close_sound = nil,
    rotating_sound = nil,
    rotating_stopped_sound = nil,
    cannon_base_shiftings = nil,
}

data:extend({ locomotive, cargo_wagon, fluid_wagon, artillery_wagon })