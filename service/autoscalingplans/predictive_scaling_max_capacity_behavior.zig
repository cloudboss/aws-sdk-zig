pub const PredictiveScalingMaxCapacityBehavior = enum {
    set_forecast_capacity_to_max_capacity,
    set_max_capacity_to_forecast_capacity,
    set_max_capacity_above_forecast_capacity,

    pub const json_field_names = .{
        .set_forecast_capacity_to_max_capacity = "SetForecastCapacityToMaxCapacity",
        .set_max_capacity_to_forecast_capacity = "SetMaxCapacityToForecastCapacity",
        .set_max_capacity_above_forecast_capacity = "SetMaxCapacityAboveForecastCapacity",
    };
};
