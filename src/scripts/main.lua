local flib_train = require("__flib__.train")

local main = {}

---@return LuaSurface
local function get_train_surface(train)
    return train.carriages[1].surface
end

---@param train LuaTrain
---@param station LuaEntity
---@return bool
local function is_train_has_station_in_schedule(train, station)
    if not train.schedule or #train.schedule.records == 0 then
        return false
    end

    local lastRecord = train.schedule.records[#train.schedule.records]

    return lastRecord.station == station.backer_name
end

---@param train LuaTrain
---@param destination_station LuaEntity
local function add_train_stop_in_schedule(train, destination_station)
    if is_train_has_station_in_schedule(train, destination_station) then
        return
    end

    local new_destination = {
        station = destination_station.backer_name,
        wait_conditions={
            {type = "time", compare_type = "and", ticks = 4000}
        }
    }

    if not train.schedule then
        train.schedule = {current = 1, records = {new_destination}}
    else
        local schedule = train.schedule
        table.insert(schedule.records, new_destination)
        schedule.current = #train.schedule.records
        train.schedule = schedule
    end

end

---@param train LuaTrain
---@return LuaEntity
local function get_locomotive(train)
    return flib_train.get_main_locomotive(train)
end

---@return string
local function get_post_action_value()
    return settings.global["stp-action-on-damaged-trains"].value
end

---@return bool
local function is_replace_only_strong_rolling_stock()
    return not settings.global["stp-use-strong-platform-for-all-trains"].value
end

---@param entity LuaEntity
---@return bool
local function is_strong_rolling_stock(entity)
    return entity.name == mod.defines.prototype.entity.strong_locomotive
            or entity.name == mod.defines.prototype.entity.strong_cargo_wagon
            or entity.name == mod.defines.prototype.entity.strong_fluid_wagon
            or entity.name == mod.defines.prototype.entity.strong_artillery_wagon
end

---@return LuaSurface
local function get_train_force(train)
    return train.carriages[1].force
end

---@param entity LuaEntity
local function is_destoyed_rolling_stock(entity)
    return entity.name == mod.defines.prototype.entity.destroyed_locomotive
            or entity.name == mod.defines.prototype.entity.destroyed_cargo_wagon
            or entity.name == mod.defines.prototype.entity.destroyed_fluid_wagon
            or entity.name == mod.defines.prototype.entity.destroyed_artillery_wagon
end

---@param train LuaTrain
local function is_train_has_destoyed_rolling_stock(train)
    for _, carriage in ipairs(train.carriages) do
        if is_destoyed_rolling_stock(carriage) then
            return true
        end
    end

    return false
end

---@param surface LuaSurface
---@param force LuaForce
local function get_destroyed_rolling_stocks(surface, force)
    local destroyed_rolling_stocks = {}
    local trains = surface.get_trains(force)

    for _, t in ipairs(trains) do
        for _, c in ipairs(t.carriages) do
            if is_destoyed_rolling_stock(c) then
                table.insert(destroyed_rolling_stocks, c)
            end
        end
    end

    return destroyed_rolling_stocks
end

local function init_global_vars()
    if global.tsp_died_rolling_stocks == nil then
        global.tsp_died_rolling_stocks = {}
    end

    if global.tsp_damaged_trains == nil then
        global.tsp_damaged_trains = {}
    end
end

function main.on_load()
    init_global_vars()
end

function main.on_init()
    init_global_vars()
end

---@param unit_number uint
function main.get_destroyed_data(unit_number)
    return global.tsp_died_rolling_stocks[unit_number]
end

---@param entity LuaEntity
function main.register_died_rolling_stock(entity)
    if is_replace_only_strong_rolling_stock() and not is_strong_rolling_stock(entity) then
        return
    end

    -- stops the train
    entity.train.speed = 0

    local fuel_inventory = entity.get_inventory(defines.inventory.fuel)

    global.tsp_died_rolling_stocks[entity.unit_number] = {
        type = entity.type,
        name = entity.name,
        position = entity.position,
        direction = entity.direction,
        force = entity.force,
        orientation = entity.orientation,
        surface = entity.surface,
        fuels = fuel_inventory ~= nil and fuel_inventory.get_contents() or nil
    }

    script.register_on_entity_destroyed(entity)
end

function main.enable_train_automatic_mode(entity)
    if entity.train then
        entity.train.manual_mode = false
    end
end

---@param unit_number uint
---@return LuaEntity
function main.try_replace_died_rolling_stock(unit_number)
    local destoyed_entity_data = main.get_destroyed_data(unit_number)

    if not destoyed_entity_data then
        return
    end

    local destroyed_map = {
        ["locomotive"] = mod.defines.prototype.entity.destroyed_locomotive,
        ["cargo-wagon"] = mod.defines.prototype.entity.destroyed_cargo_wagon,
        ["fluid-wagon"] = mod.defines.prototype.entity.destroyed_fluid_wagon,
        ["artillery-wagon"] = mod.defines.prototype.entity.destroyed_artillery_wagon,
    }
    local destroyed_entity_name = destroyed_map[destoyed_entity_data.type]

    local new_rolling_stock = destoyed_entity_data.surface.create_entity({
        name = destroyed_entity_name,
        position = destoyed_entity_data.position,
        direction = destoyed_entity_data.direction,
        force = destoyed_entity_data.force,
        move_stuck_players  = true,
        orientation = destoyed_entity_data.orientation,
    })

    if new_rolling_stock == nil then
        for _, player in ipairs(destoyed_entity_data.force.players) do
            player.print({"console.stp-error-cant-place-destroyed-rolling-stock"}, {r = 0.7, a = 0.5})
            log("Cant place destroyed rolling stock")
        end

        return
    end

    if new_rolling_stock.type == "locomotive" then
        local fuel_inventory = new_rolling_stock.get_inventory(defines.inventory.fuel)

        for fueld_name, fuel_count in pairs(destoyed_entity_data.fuels) do
            fuel_inventory.insert({name = fueld_name, count = fuel_count})
            break
        end
    end

    global.tsp_died_rolling_stocks[unit_number] = nil

    main.post_train_action(new_rolling_stock.train)

    main.enable_train_automatic_mode(new_rolling_stock)
end

---@param train LuaTrain
function main.update_alert_message(train)
    local rolling_stock = train.carriages[1]
    local surface = rolling_stock.surface
    local force = rolling_stock.force
    local destroyed_rolling_stocks = get_destroyed_rolling_stocks(surface, force)
    local icon = { type = "virtual", name = "stp-destroyed-rolling-stock" }

    if #destroyed_rolling_stocks > 0 then
        for _, player in ipairs(rolling_stock.force.players) do
            for _, entity in ipairs(destroyed_rolling_stocks) do
                player.add_custom_alert(entity, icon, {"alert-message.stp-destroyed-rolling-stock"}, true)
            end
        end
    else

    end
end

---@param train LuaTrain
---@param old_train_id_1 uint
---@param old_train_id_2 uint
function main.update_list_of_damaged_trains(train, old_train_id_1, old_train_id_2)
    local train_with_destroyed_rolling_stock = is_train_has_destoyed_rolling_stock(train)

    if old_train_id_1 then -- old_train_id_1 maked a part of new train
        global.tsp_damaged_trains[old_train_id_1] = nil
    end

    if old_train_id_2 then -- old_train_id_2 maked a part of new train
        global.tsp_damaged_trains[old_train_id_2] = nil
    end

    if not train_with_destroyed_rolling_stock then
        return
    end

    global.tsp_damaged_trains[train.id] = {
        id = train.id,
    }
end

---@param surface LuaSurface
---@param force LuaForce
---@return nil|LuaEntity
function main.get_train_station_for_destroyed_trains(surface, force)
    for _, stop in ipairs(surface.get_train_stops{force=force}) do
        local signals = stop.get_merged_signals()

        if signals then
            ---@param signal Signal
            for _, signal in ipairs(stop.get_merged_signals()) do
                if signal.signal.name == mod.defines.signal_destroyed_rolling_stock_depot_station then
                    return stop
                end
            end
        end
    end

    return nil
end

---@param train LuaTrain
function main.process_train_arrived(train)
    if not train.station or not is_train_has_destoyed_rolling_stock(train) then
        return
    end

    local post_action = get_post_action_value()

    if post_action == mod.defines.post_action.nothing then
        return
    end

    local surface = get_train_surface(train);
    local force = get_train_force(train);
    local destination_station = main.get_train_station_for_destroyed_trains(surface, force)

    if train.station.backer_name == destination_station.backer_name then
        if post_action == mod.defines.post_action.station_manual then
            train.manual_mode = true
            return
        end

        if post_action == mod.defines.post_action.station_clean_schedule then
            train.schedule = nil
        end
    end

end

---@param train LuaTrain
function main.post_train_action(train)
    local post_action = get_post_action_value()

    if post_action == mod.defines.post_action.nothing then
        return
    end

    local surface = get_train_surface(train);
    local force = get_train_force(train);
    local destination_station = main.get_train_station_for_destroyed_trains(surface, force)
    local locomotive = get_locomotive(train)

    if not destination_station or not locomotive then
        return
    end

    if destination_station and (post_action == mod.defines.post_action.station_manual or post_action == mod.defines.post_action.station_clean_schedule) then
        add_train_stop_in_schedule(locomotive.train, destination_station)
    end
end

return main