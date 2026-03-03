/// Represents a single value in the forecast data used for predictive scaling.
pub const Datapoint = struct {
    /// The time stamp for the data point in UTC format.
    timestamp: ?i64 = null,

    /// The value of the data point.
    value: ?f64 = null,

    pub const json_field_names = .{
        .timestamp = "Timestamp",
        .value = "Value",
    };
};
