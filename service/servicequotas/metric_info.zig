const aws = @import("aws");

/// Information about the CloudWatch metric that reflects quota usage.
pub const MetricInfo = struct {
    /// The metric dimension. This is a name/value pair that is part of the identity
    /// of a
    /// metric.
    metric_dimensions: ?[]const aws.map.StringMapEntry,

    /// The name of the metric.
    metric_name: ?[]const u8,

    /// The namespace of the metric.
    metric_namespace: ?[]const u8,

    /// The metric statistic that we recommend you use when determining quota usage.
    metric_statistic_recommendation: ?[]const u8,

    pub const json_field_names = .{
        .metric_dimensions = "MetricDimensions",
        .metric_name = "MetricName",
        .metric_namespace = "MetricNamespace",
        .metric_statistic_recommendation = "MetricStatisticRecommendation",
    };
};
