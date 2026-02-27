/// Provides detailed error metrics to evaluate the performance of a predictor.
/// This object
/// is part of the Metrics object.
pub const ErrorMetric = struct {
    /// The Forecast type used to compute WAPE, MAPE, MASE, and RMSE.
    forecast_type: ?[]const u8,

    /// The Mean Absolute Percentage Error (MAPE)
    mape: ?f64,

    /// The Mean Absolute Scaled Error (MASE)
    mase: ?f64,

    /// The root-mean-square error (RMSE).
    rmse: ?f64,

    /// The weighted absolute percentage error (WAPE).
    wape: ?f64,

    pub const json_field_names = .{
        .forecast_type = "ForecastType",
        .mape = "MAPE",
        .mase = "MASE",
        .rmse = "RMSE",
        .wape = "WAPE",
    };
};
