const DateInterval = @import("date_interval.zig").DateInterval;

/// The forecast that's created for your query.
pub const ForecastResult = struct {
    /// The mean value of the forecast.
    mean_value: ?[]const u8 = null,

    /// The lower limit for the prediction interval.
    prediction_interval_lower_bound: ?[]const u8 = null,

    /// The upper limit for the prediction interval.
    prediction_interval_upper_bound: ?[]const u8 = null,

    /// The period of time that the forecast covers.
    time_period: ?DateInterval = null,

    pub const json_field_names = .{
        .mean_value = "MeanValue",
        .prediction_interval_lower_bound = "PredictionIntervalLowerBound",
        .prediction_interval_upper_bound = "PredictionIntervalUpperBound",
        .time_period = "TimePeriod",
    };
};
