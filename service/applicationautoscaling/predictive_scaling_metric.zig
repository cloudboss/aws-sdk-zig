const PredictiveScalingMetricDimension = @import("predictive_scaling_metric_dimension.zig").PredictiveScalingMetricDimension;

/// Describes the scaling metric.
pub const PredictiveScalingMetric = struct {
    /// Describes the dimensions of the metric.
    dimensions: ?[]const PredictiveScalingMetricDimension = null,

    /// The name of the metric.
    metric_name: ?[]const u8 = null,

    /// The namespace of the metric.
    namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .metric_name = "MetricName",
        .namespace = "Namespace",
    };
};
