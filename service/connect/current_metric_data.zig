const CurrentMetric = @import("current_metric.zig").CurrentMetric;

/// Contains the data for a real-time metric.
pub const CurrentMetricData = struct {
    /// Information about the metric.
    metric: ?CurrentMetric,

    /// The value of the metric.
    value: ?f64,

    pub const json_field_names = .{
        .metric = "Metric",
        .value = "Value",
    };
};
