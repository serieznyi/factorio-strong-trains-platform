local prototype_defines = require("defines")
local items = {}

------------- ITEM
local item = {
    type = "item",
    subgroup = "train-transport",
    name = prototype_defines.item.destroyed_locomotive,
    icon = "__StrongTrainsPlatform__/graphics/item/destroyed/locomotive.png",
    icon_size = 64,
    stack_size = 1,
    place_result = prototype_defines.entity.destroyed_locomotive,
    default_request_amount = 1,
}
table.insert(items, item)

------------- ITEM
item = {
    type = "item",
    subgroup = "train-transport",
    name = prototype_defines.item.destroyed_cargo_wagon,
    icon = "__StrongTrainsPlatform__/graphics/item/destroyed/wagon.png",
    icon_size = 64,
    stack_size = 1,
    place_result = prototype_defines.entity.destroyed_cargo_wagon,
    default_request_amount = 1,
}
table.insert(items, item)

------------- ITEM
item = {
    type = "item",
    subgroup = "train-transport",
    name = prototype_defines.item.destroyed_fluid_wagon,
    icon = "__StrongTrainsPlatform__/graphics/item/destroyed/fluid-wagon.png",
    icon_size = 64,
    stack_size = 1,
    place_result = prototype_defines.entity.destroyed_fluid_wagon,
    default_request_amount = 1,
}
table.insert(items, item)

------------- ITEM
item = {
    type = "item",
    subgroup = "train-transport",
    name = prototype_defines.item.destroyed_artillery_wagon,
    icon = "__StrongTrainsPlatform__/graphics/item/destroyed/artillery-wagon.png",
    icon_size = 64,
    stack_size = 1,
    place_result = prototype_defines.entity.destroyed_artillery_wagon,
    default_request_amount = 1,
}
table.insert(items, item)

------------- ITEM: Locomotive
item = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
item.name = prototype_defines.item.strong_locomotive
item.icon = "__StrongTrainsPlatform__/graphics/item/strong/locomotive.png"
item.order = "a[train-system]-ia[locomotive]"
item.place_result = prototype_defines.entity.strong_locomotive
table.insert(items, item)

------------ ITEM: Fluid Wagon
item = table.deepcopy(data.raw["item-with-entity-data"]["fluid-wagon"])
item.name = prototype_defines.item.strong_fluid_wagon
item.icon = "__StrongTrainsPlatform__/graphics/item/strong/fluid-wagon.png"
item.place_result = prototype_defines.entity.strong_fluid_wagon
item.order = "a[train-system]-ic[fluid-wagon]"
table.insert(items, item)

------------ ITEM: Cargo Wagon
item = table.deepcopy(data.raw["item-with-entity-data"]["cargo-wagon"])
item.name = prototype_defines.item.strong_cargo_wagon
item.icon = "__StrongTrainsPlatform__/graphics/item/strong/cargo-wagon.png"
item.place_result = prototype_defines.entity.strong_cargo_wagon
item.order = "a[train-system]-ib[cargo-wagon]"
table.insert(items, item)

------------ ITEM: Artillery Wagon
item = table.deepcopy(data.raw["item-with-entity-data"]["artillery-wagon"])
item.name = prototype_defines.item.strong_artillery_wagon
item.icon = "__StrongTrainsPlatform__/graphics/item/strong/artillery-wagon.png"
item.place_result = prototype_defines.entity.strong_artillery_wagon
item.order = "a[train-system]-id[artillery-wagon]"
table.insert(items, item)

data:extend(items)