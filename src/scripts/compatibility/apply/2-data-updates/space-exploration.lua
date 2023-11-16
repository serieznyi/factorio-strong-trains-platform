local prototype_defines = require("prototypes.defines")

local main = {}

function main.register_recycle_recipes_for_destroyed_rolling_stock()
    ---@param se_recycling_facility_technology TechnologyPrototype
    local se_recycling_facility_technology = data.raw.technology["se-recycling-facility"]
    local recipe = nil

    -- Destroyed Locomotive Recycling

    recipe = {
        type = "recipe",
        name = "atd-se-recycle-destroyed-locomotive",
        icon = "__StrongTrainsPlatform__/graphics/recipe/se-recycle/recycle-locomotive.png",
        icon_size = 64,
        enabled = se_recycling_facility_technology.enabled,
        category = "hard-recycling",
        subgroup = "recycling",
        energy_required = 10,
        ingredients = {{prototype_defines.item.destroyed_locomotive, 1}},
        results = {{type="item", name="se-scrap", amount=30}}
    }

    data:extend{recipe}
    table.insert(se_recycling_facility_technology.effects, { type = "unlock-recipe", recipe = recipe.name })

    -- Destroyed Cargo Wagon Recycling

    recipe = {
        type = "recipe",
        name = "atd-se-recycle-destroyed-cargo-wagon",
        icon = "__StrongTrainsPlatform__/graphics/recipe/se-recycle/recycle-cargo-wagon.png",
        icon_size = 64,
        enabled = se_recycling_facility_technology.enabled,
        category = "hard-recycling",
        subgroup = "recycling",
        energy_required = 5,
        ingredients = {{prototype_defines.item.destroyed_cargo_wagon, 1}},
        results = {{type="item", name="se-scrap", amount=10}}
    }

    data.raw.recipe["atd-se-recycle-destroyed-cargo-wagon"] = recipe
    table.insert(se_recycling_facility_technology.effects, { type = "unlock-recipe", recipe = recipe.name })

    -- Destroyed Fluid Wagon Recycling

    recipe = {
        type = "recipe",
        name = "atd-se-recycle-destroyed-fluid-wagon",
        icon = "__StrongTrainsPlatform__/graphics/recipe/se-recycle/recycle-fluid-wagon.png",
        icon_size = 64,
        enabled = se_recycling_facility_technology.enabled,
        category = "hard-recycling",
        subgroup = "recycling",
        energy_required = 5,
        ingredients = {{prototype_defines.item.destroyed_fluid_wagon, 1}},
        results = {{type="item", name="se-scrap", amount=10}}
    }

    data.raw.recipe["atd-se-recycle-destroyed-fluid-wagon"] = recipe
    table.insert(se_recycling_facility_technology.effects, { type = "unlock-recipe", recipe = recipe.name })

    -- Destroyed Artillery Wagon Recycling

    recipe = {
        type = "recipe",
        name = "atd-se-recycle-destroyed-artillery-wagon",
        icon = "__StrongTrainsPlatform__/graphics/recipe/se-recycle/recycle-artillery-wagon.png",
        icon_size = 64,
        enabled = se_recycling_facility_technology.enabled,
        category = "hard-recycling",
        subgroup = "recycling",
        energy_required = 5,
        ingredients = {{prototype_defines.item.destroyed_artillery_wagon, 1}},
        results = {{type="item", name="se-scrap", amount=20}}
    }

    data.raw.recipe["atd-se-recycle-destroyed-artillery-wagon"] = recipe
    table.insert(se_recycling_facility_technology.effects, { type = "unlock-recipe", recipe = recipe.name })
end

return main
