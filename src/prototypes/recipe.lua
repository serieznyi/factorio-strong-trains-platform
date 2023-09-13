local prototype_defines = require("defines")

local steel_increment = 50
local energy_increment = 1

local strong_fluid_wagon = {
    type = "recipe",
    name = prototype_defines.recipe.strong_fluid_wagon,
    enabled = false,
    energy_required = energy_increment + 1.5,
    ingredients =
    {
        {"iron-gear-wheel", 10},
        {"steel-plate", steel_increment + 16},
        {"pipe", 8},
        {"storage-tank", 1}
    },
    result = prototype_defines.item.strong_fluid_wagon
}

local strong_cargo_wagon = {
    type = "recipe",
    name = prototype_defines.recipe.strong_cargo_wagon,
    energy_required = energy_increment + 1,
    enabled = false,
    ingredients =
    {
        {"iron-gear-wheel", 10},
        {"iron-plate", 20},
        {"steel-plate", steel_increment + 20}
    },
    result = prototype_defines.item.strong_cargo_wagon
}

local strong_artillery_wagon = {
    type = "recipe",
    name = prototype_defines.recipe.strong_artillery_wagon,
    energy_required = energy_increment + 4,
    enabled = false,
    ingredients =
    {
        {"engine-unit", 64},
        {"iron-gear-wheel", 10},
        {"steel-plate", steel_increment + 40},
        {"pipe", 16},
        {"advanced-circuit", 20}
    },
    result = prototype_defines.item.strong_artillery_wagon
}

local strong_locomotive = {
    type = "recipe",
    name = prototype_defines.recipe.strong_locomotive,
    energy_required = energy_increment + 4,
    enabled = false,
    ingredients =
    {
        {"engine-unit", 20},
        {"electronic-circuit", 10},
        {"steel-plate", steel_increment + 30}
    },
    result = prototype_defines.item.strong_locomotive
}

data:extend({
    strong_fluid_wagon,
    strong_cargo_wagon,
    strong_artillery_wagon,
    strong_locomotive,
})