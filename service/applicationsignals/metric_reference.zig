const Dimension = @import("dimension.zig").Dimension;

/// This structure contains information about one CloudWatch metric associated
/// with this entity discovered by Application Signals.
pub const MetricReference = struct {
    /// Amazon Web Services account ID.
    account_id: ?[]const u8,

    /// An array of one or more dimensions that further define the metric. For more
    /// information, see
    /// [CloudWatchDimensions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Dimension).
    dimensions: ?[]const Dimension,

    /// The name of the metric.
    metric_name: []const u8,

    /// Used to display the appropriate statistics in the CloudWatch console.
    metric_type: []const u8,

    /// The namespace of the metric. For more information, see
    /// [CloudWatchNamespaces](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Namespace).
    namespace: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .dimensions = "Dimensions",
        .metric_name = "MetricName",
        .metric_type = "MetricType",
        .namespace = "Namespace",
    };
};
