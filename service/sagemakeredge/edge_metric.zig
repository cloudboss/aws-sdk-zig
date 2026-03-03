/// Information required for edge device metrics.
pub const EdgeMetric = struct {
    /// The dimension of metrics published.
    dimension: ?[]const u8 = null,

    /// Returns the name of the metric.
    metric_name: ?[]const u8 = null,

    /// Timestamp of when the metric was requested.
    timestamp: ?i64 = null,

    /// Returns the value of the metric.
    value: ?f64 = null,

    pub const json_field_names = .{
        .dimension = "Dimension",
        .metric_name = "MetricName",
        .timestamp = "Timestamp",
        .value = "Value",
    };
};
