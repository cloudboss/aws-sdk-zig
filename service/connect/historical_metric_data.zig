const HistoricalMetric = @import("historical_metric.zig").HistoricalMetric;

/// Contains the data for a historical metric.
pub const HistoricalMetricData = struct {
    /// Information about the metric.
    metric: ?HistoricalMetric,

    /// The value of the metric.
    value: ?f64,

    pub const json_field_names = .{
        .metric = "Metric",
        .value = "Value",
    };
};
