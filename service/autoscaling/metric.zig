const MetricDimension = @import("metric_dimension.zig").MetricDimension;

/// Represents a specific metric.
pub const Metric = struct {
    /// The dimensions for the metric. For the list of available dimensions, see the
    /// Amazon Web Services
    /// documentation available from the table in [Amazon Web Services
    /// services that publish CloudWatch metrics
    /// ](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html) in the *Amazon CloudWatch User
    /// Guide*.
    ///
    /// Conditional: If you published your metric with dimensions, you must specify
    /// the same
    /// dimensions in your scaling policy.
    dimensions: ?[]const MetricDimension,

    /// The name of the metric.
    metric_name: []const u8,

    /// The namespace of the metric. For more information, see the table in [Amazon
    /// Web Services
    /// services that publish CloudWatch metrics
    /// ](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html) in the *Amazon CloudWatch User
    /// Guide*.
    namespace: []const u8,
};
