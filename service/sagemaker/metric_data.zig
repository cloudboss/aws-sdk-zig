/// The name, value, and date and time of a metric that was emitted to Amazon
/// CloudWatch.
pub const MetricData = struct {
    /// The name of the metric.
    metric_name: ?[]const u8 = null,

    /// The date and time that the algorithm emitted the metric.
    timestamp: ?i64 = null,

    /// The value of the metric.
    value: ?f32 = null,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .timestamp = "Timestamp",
        .value = "Value",
    };
};
