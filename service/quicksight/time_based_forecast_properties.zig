/// The forecast properties setup of a forecast in the line chart.
pub const TimeBasedForecastProperties = struct {
    /// The lower boundary setup of a forecast computation.
    lower_boundary: ?f64 = null,

    /// The periods backward setup of a forecast computation.
    periods_backward: ?i32 = null,

    /// The periods forward setup of a forecast computation.
    periods_forward: ?i32 = null,

    /// The prediction interval setup of a forecast computation.
    prediction_interval: ?i32 = null,

    /// The seasonality setup of a forecast computation. Choose one of the following
    /// options:
    ///
    /// * `NULL`: The input is set to `NULL`.
    ///
    /// * `NON_NULL`: The input is set to a custom value.
    seasonality: ?i32 = null,

    /// The upper boundary setup of a forecast computation.
    upper_boundary: ?f64 = null,

    pub const json_field_names = .{
        .lower_boundary = "LowerBoundary",
        .periods_backward = "PeriodsBackward",
        .periods_forward = "PeriodsForward",
        .prediction_interval = "PredictionInterval",
        .seasonality = "Seasonality",
        .upper_boundary = "UpperBoundary",
    };
};
