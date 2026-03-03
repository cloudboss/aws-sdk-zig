/// The raw metric data to associate with the resource.
pub const RawMetricData = struct {
    /// The name of the metric.
    metric_name: []const u8,

    /// The metric step (epoch).
    step: ?i32 = null,

    /// The time that the metric was recorded.
    timestamp: i64,

    /// The metric value.
    value: f64,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .step = "Step",
        .timestamp = "Timestamp",
        .value = "Value",
    };
};
