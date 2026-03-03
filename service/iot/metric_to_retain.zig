const MetricDimension = @import("metric_dimension.zig").MetricDimension;

/// The metric you want to retain. Dimensions are optional.
pub const MetricToRetain = struct {
    /// The value indicates exporting metrics related to the `MetricToRetain ` when
    /// it's true.
    export_metric: ?bool = null,

    /// What is measured by the behavior.
    metric: []const u8,

    /// The dimension of a metric. This can't be used with custom metrics.
    metric_dimension: ?MetricDimension = null,

    pub const json_field_names = .{
        .export_metric = "exportMetric",
        .metric = "metric",
        .metric_dimension = "metricDimension",
    };
};
