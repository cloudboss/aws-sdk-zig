/// Information about an Amazon CloudWatch metric that is analyzed by DevOps
/// Guru. It is one of many
/// analyzed metrics that are used to generate insights.
pub const RecommendationRelatedCloudWatchMetricsSourceDetail = struct {
    /// The name of the CloudWatch metric.
    metric_name: ?[]const u8,

    /// The namespace of the CloudWatch metric. A namespace is a container for
    /// CloudWatch metrics.
    namespace: ?[]const u8,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .namespace = "Namespace",
    };
};
