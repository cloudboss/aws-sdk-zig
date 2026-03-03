const MetricValue = @import("metric_value.zig").MetricValue;

/// A metric.
pub const MetricDatum = struct {
    /// The time the metric value was reported.
    timestamp: ?i64 = null,

    /// The value reported for the metric.
    value: ?MetricValue = null,

    pub const json_field_names = .{
        .timestamp = "timestamp",
        .value = "value",
    };
};
