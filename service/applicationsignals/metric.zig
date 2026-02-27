const Dimension = @import("dimension.zig").Dimension;

/// This structure defines the metric used for a service level indicator,
/// including the metric name, namespace, and dimensions
pub const Metric = struct {
    /// An array of one or more dimensions to use to define the metric that you want
    /// to use. For more information, see
    /// [Dimensions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Dimension).
    dimensions: ?[]const Dimension,

    /// The name of the metric to use.
    metric_name: ?[]const u8,

    /// The namespace of the metric. For more information, see
    /// [Namespaces](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Namespace).
    namespace: ?[]const u8,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .metric_name = "MetricName",
        .namespace = "Namespace",
    };
};
