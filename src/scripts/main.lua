local main = {}

---@param entity LuaEntity
local function is_destoyed_rolling_stock(entity)
    return entity.name == mod.defines.prototypes.entity.destroyed_locomotive
            or entity.name == mod.defines.prototypes.entity.destroyed_wagon
            or entity.name == mod.defines.prototypes.entity.destroyed_fluid_wagon
            or entity.name == mod.defines.prototypes.entity.destroyed_artillery_wagon
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

---@param unit_number uint
function main.get_destroyed_data(unit_number)
    return global.tsp_died_rolling_stocks[unit_number]
end

---@param entity LuaEntity
function main.register_died_rolling_stock(entity)
    -- stops the train
    entity.train.speed = 0

    if global.tsp_died_rolling_stocks == nil then
        global.tsp_died_rolling_stocks = {}
    end

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
function main.replace_died_rolling_stock(unit_number)
    local destoyed_entity_data = main.get_destroyed_data(unit_number)

    print(destoyed_entity_data.type)

    local destroyed_map = {
        ["locomotive"] = mod.defines.prototypes.entity.destroyed_locomotive,
        ["cargo-wagon"] = mod.defines.prototypes.entity.destroyed_wagon,
        ["fluid-wagon"] = mod.defines.prototypes.entity.destroyed_fluid_wagon,
        ["artillery-wagon"] = mod.defines.prototypes.entity.destroyed_artillery_wagon,
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

return main