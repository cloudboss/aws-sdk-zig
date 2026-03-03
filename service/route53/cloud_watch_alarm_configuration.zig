const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const Dimension = @import("dimension.zig").Dimension;
const Statistic = @import("statistic.zig").Statistic;

/// A complex type that contains information about the CloudWatch alarm that
/// Amazon Route
/// 53 is monitoring for this health check.
pub const CloudWatchAlarmConfiguration = struct {
    /// For the metric that the CloudWatch alarm is associated with, the arithmetic
    /// operation
    /// that is used for the comparison.
    comparison_operator: ComparisonOperator,

    /// For the metric that the CloudWatch alarm is associated with, a complex type
    /// that
    /// contains information about the dimensions for the metric. For information,
    /// see [Amazon
    /// CloudWatch Namespaces, Dimensions, and Metrics
    /// Reference](https://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html) in the
    /// *Amazon CloudWatch User Guide*.
    dimensions: ?[]const Dimension = null,

    /// For the metric that the CloudWatch alarm is associated with, the number of
    /// periods
    /// that the metric is compared to the threshold.
    evaluation_periods: i32,

    /// The name of the CloudWatch metric that the alarm is associated with.
    metric_name: []const u8,

    /// The namespace of the metric that the alarm is associated with. For more
    /// information,
    /// see [Amazon
    /// CloudWatch Namespaces, Dimensions, and Metrics
    /// Reference](https://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html) in the
    /// *Amazon CloudWatch User Guide*.
    namespace: []const u8,

    /// For the metric that the CloudWatch alarm is associated with, the duration of
    /// one
    /// evaluation period in seconds.
    period: i32,

    /// For the metric that the CloudWatch alarm is associated with, the statistic
    /// that is
    /// applied to the metric.
    statistic: Statistic,

    /// For the metric that the CloudWatch alarm is associated with, the value the
    /// metric is
    /// compared with.
    threshold: f64,
};
