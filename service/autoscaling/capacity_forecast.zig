/// A `GetPredictiveScalingForecast` call returns the capacity forecast for a
/// predictive scaling policy. This structure includes the data points for that
/// capacity
/// forecast, along with the timestamps of those data points.
pub const CapacityForecast = struct {
    /// The timestamps for the data points, in UTC format.
    timestamps: []const i64,

    /// The values of the data points.
    values: []const f64,
};
