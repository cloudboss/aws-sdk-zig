pub const PredictiveScalingMode = enum {
    forecast_only,
    forecast_and_scale,

    pub const json_field_names = .{
        .forecast_only = "ForecastOnly",
        .forecast_and_scale = "ForecastAndScale",
    };
};
