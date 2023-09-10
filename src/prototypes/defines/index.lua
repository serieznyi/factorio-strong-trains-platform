return {
    prototypes = {
        entity = {
            destroyed_locomotive = "stp-destroyed-locomotive",
            destroyed_wagon = "stp-destroyed-wagon",
            destroyed_fluid_wagon = "stp-destroyed-fluid-wagon",
            destroyed_artillery_wagon = "stp-destroyed-artillery-wagon",
        },
        item = {
            destroyed_locomotive = "stp-destroyed-locomotive",
            destroyed_wagon = "stp-destroyed-wagon",
            destroyed_fluid_wagon = "stp-destroyed-fluid-wagon",
            destroyed_artillery_wagon = "stp-destroyed-artillery-wagon",
        },
    },
    post_action = {
        nothing = "nothing",
        station_manual = "station-manual",
        station_clean_schedule = "station-clean-schedule"
    },
    signal_destroyed_rolling_stock_depot_station = "stp-destroyed-rolling-stock-depot-station"
}