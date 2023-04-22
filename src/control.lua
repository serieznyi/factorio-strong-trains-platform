mod = require("scripts.mod")
local main = require("scripts.main")

local function handle_on_entity_died(event)
    local entity = event.entity

    main.register_died_rolling_stock(entity)
end

local function handle_on_entity_destroyed(event)
    main.replace_died_rolling_stock(event.unit_number)
end

local function handle_on_train_created(event)
    main.update_alert_message(event.train)
end

---------------------------------------------------------------------------
-- -- -- REGISTER EVENTS
---------------------------------------------------------------------------

script.on_event(defines.events.on_entity_died, handle_on_entity_died, {{ filter = "rolling-stock"}})
script.on_event(defines.events.on_entity_destroyed, handle_on_entity_destroyed)
script.on_event(defines.events.on_train_created, handle_on_train_created)