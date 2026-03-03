/// A pair that contains metric values at the respective timestamp.
pub const TimestampMetricValuePair = struct {
    /// Value of the anomalous metric data point at respective Timestamp.
    metric_value: ?f64 = null,

    /// A `Timestamp` that specifies the time the event occurred.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .metric_value = "MetricValue",
        .timestamp = "Timestamp",
    };
};
