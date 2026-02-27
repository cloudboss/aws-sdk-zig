pub const ForecastDataType = enum {
    capacity_forecast,
    load_forecast,
    scheduled_action_min_capacity,
    scheduled_action_max_capacity,

    pub const json_field_names = .{
        .capacity_forecast = "CapacityForecast",
        .load_forecast = "LoadForecast",
        .scheduled_action_min_capacity = "ScheduledActionMinCapacity",
        .scheduled_action_max_capacity = "ScheduledActionMaxCapacity",
    };
};
