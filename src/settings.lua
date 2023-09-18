data:extend({
    {
        type = "string-setting",
        name = "stp-action-on-damaged-trains",
        setting_type = "runtime-global",
        default_value = "nothing",
        allowed_values = {"nothing", "station-manual", "station-clean-schedule"}
    },
    {
        type = "bool-setting",
        name = "stp-use-strong-platform-for-all-rolling-stock",
        setting_type = "runtime-global",
        default_value = false
    },
})