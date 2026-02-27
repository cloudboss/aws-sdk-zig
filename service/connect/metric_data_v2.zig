const MetricV2 = @import("metric_v2.zig").MetricV2;

/// Contains the name, thresholds, and metric filters.
pub const MetricDataV2 = struct {
    /// The metric name or metricId, thresholds, and metric filters of the returned
    /// metric.
    metric: ?MetricV2,

    /// The corresponding value of the metric returned in the response.
    value: ?f64,

    pub const json_field_names = .{
        .metric = "Metric",
        .value = "Value",
    };
};
