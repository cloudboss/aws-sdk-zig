/// Information required for edge device metrics.
pub const EdgeMetric = struct {
    /// The dimension of metrics published.
    dimension: ?[]const u8,

    /// Returns the name of the metric.
    metric_name: ?[]const u8,

    /// Timestamp of when the metric was requested.
    timestamp: ?i64,

    /// Returns the value of the metric.
    value: ?f64,

    pub const json_field_names = .{
        .dimension = "Dimension",
        .metric_name = "MetricName",
        .timestamp = "Timestamp",
        .value = "Value",
    };
};
