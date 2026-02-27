pub const PredictiveScalingMode = enum {
    forecast_and_scale,
    forecast_only,

    pub const json_field_names = .{
        .forecast_and_scale = "ForecastAndScale",
        .forecast_only = "ForecastOnly",
    };
};
