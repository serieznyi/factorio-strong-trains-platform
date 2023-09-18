local prototype_defines = require("defines")
local technologies = {}

------------- TECHNOLOGY: strong locomotive - basic

local technology = table.deepcopy(data.raw["technology"]["railway"])
technology.name = "strong-train-platform-basic-technology"
technology.icon = "__StrongTrainsPlatform__/graphics/technology/strong-railway.png"
technology.effects = {
    {
        type = "unlock-recipe",
        recipe = prototype_defines.recipe.strong_locomotive,
    },
    {
        type = "unlock-recipe",
        recipe = prototype_defines.recipe.strong_cargo_wagon,
    },
}
technology.prerequisites = {
    "railway",
}
technology.unit.count = technology.unit.count * 2

table.insert(technologies, technology)

------------- TECHNOLOGY: strong locomotive - fluid wagon

technology = table.deepcopy(data.raw["technology"]["fluid-wagon"])
technology.name = "strong-train-platform-fluid-wagon-technology"
technology.icon = "__StrongTrainsPlatform__/graphics/technology/strong-fluid-wagon.png"
technology.effects = {
    {
        type = "unlock-recipe",
        recipe = prototype_defines.recipe.strong_fluid_wagon,
    },
}
technology.prerequisites = {
    "fluid-wagon"
}
technology.unit.count = technology.unit.count * 2
table.insert(technologies, technology)

------------- TECHNOLOGY: strong locomotive - artillery

technology = table.deepcopy(data.raw["technology"]["artillery"])
technology.name = "strong-train-platform-artillery-technology"
technology.icon = "__StrongTrainsPlatform__/graphics/technology/strong-artillery.png"
technology.effects = {
    {
        type = "unlock-recipe",
        recipe = prototype_defines.recipe.strong_artillery_wagon,
    },
}
technology.prerequisites = {
    "artillery"
}
technology.unit.count = technology.unit.count * 2
table.insert(technologies, technology)

data:extend(technologies)