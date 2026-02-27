const aws = @import("aws");

const DataPoint = @import("data_point.zig").DataPoint;

/// Provides information about a forecast. Returned as part of the QueryForecast
/// response.
pub const Forecast = struct {
    /// The forecast.
    ///
    /// The *string* of the string-to-array map is one of the following
    /// values:
    ///
    /// * p10
    ///
    /// * p50
    ///
    /// * p90
    ///
    /// The default setting is `["0.1", "0.5", "0.9"]`. Use the optional
    /// `ForecastTypes` parameter of the
    /// [CreateForecast](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateForecast.html) operation to change the values. The values will vary depending on how this is set, with a minimum of `1` and a maximum of `5.`
    predictions: ?[]const aws.map.MapEntry([]const DataPoint),

    pub const json_field_names = .{
        .predictions = "Predictions",
    };
};
