local space_exploration = require("space-exploration")

-- SE recycling
if mods["space-exploration"] then
    space_exploration.register_recycle_recipes_for_destroyed_rolling_stock()
end