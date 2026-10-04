/// Specifies which metrics Amazon CloudWatch collects for a resource metrics
/// configuration. Include this in a
/// [CreateResourceMetricsConfiguration](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_CreateResourceMetricsConfiguration.html) or [UpdateResourceMetricsConfiguration](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_UpdateResourceMetricsConfiguration.html) request to limit collection to a specific
/// set of metrics. If you omit metric selections, Amazon CloudWatch collects
/// all
/// available detailed metrics for the resource.
pub const ResourceMetricSelection = struct {
    /// The names of the metrics to collect for the resource. Amazon CloudWatch
    /// collects
    /// only the metrics that you list here.
    include_metrics: []const []const u8,

    pub const json_field_names = .{
        .include_metrics = "IncludeMetrics",
    };
};
