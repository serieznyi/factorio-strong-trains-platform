mod = require("scripts.mod")
local main = require("scripts.main")

local function handle_on_entity_died(event)
    local entity = event.entity

    main.register_died_rolling_stock(entity)
end

local function handle_on_train_changed_state(event)
    local train = event.train

    if train.state == defines.train_state.wait_station then
        main.process_train_arrived(train)
    end
end

local function handle_on_entity_destroyed(event)
    main.try_replace_died_rolling_stock(event.unit_number)
end

local function handle_on_train_created(event)
    main.post_train_action(event.train)
    main.update_list_of_damaged_trains(event.train, event.old_train_id_1, event.old_train_id_2)
end

local function handle_on_load()
    main.on_load()
end

local function handle_on_init()
    main.on_init()
end

---------------------------------------------------------------------------
-- -- -- REGISTER EVENTS
---------------------------------------------------------------------------
script.on_init(handle_on_init)
script.on_load(handle_on_load)
script.on_event(defines.events.on_entity_died, handle_on_entity_died, {
    { filter = "rolling-stock" },
    -- ignore destroyed rolling stock
    { filter = "name", name = mod.defines.prototype.entity.destroyed_artillery_wagon, mode = "and", invert = true },
    { filter = "name", name = mod.defines.prototype.entity.destroyed_fluid_wagon, mode = "and", invert = true },
    { filter = "name", name = mod.defines.prototype.entity.destroyed_cargo_wagon, mode = "and", invert = true },
    { filter = "name", name = mod.defines.prototype.entity.destroyed_locomotive, mode = "and", invert = true }
})
script.on_event(defines.events.on_entity_destroyed, handle_on_entity_destroyed)
script.on_event(defines.events.on_train_created, handle_on_train_created)
script.on_event(defines.events.on_train_changed_state, handle_on_train_changed_state)