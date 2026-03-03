const Metric = @import("metric.zig").Metric;

/// This structure defines the CloudWatch metric to return, along with the
/// statistic and
/// unit.
///
/// For more information about the CloudWatch terminology below, see [Amazon
/// CloudWatch
/// concepts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html) in the *Amazon CloudWatch User Guide*.
pub const TargetTrackingMetricStat = struct {
    /// The metric to use.
    metric: Metric,

    /// The period of the metric in seconds. The default value is 60. Accepted
    /// values are 10, 30, and 60. For high resolution metric, set the value to less
    /// than 60. For more information, see
    /// [Create a target tracking policy using high-resolution metrics for faster
    /// response](https://docs.aws.amazon.com/autoscaling/ec2/userguide/policy-creating-high-resolution-metrics.html).
    period: ?i32 = null,

    /// The statistic to return. It can include any CloudWatch statistic or extended
    /// statistic. For
    /// a list of valid values, see the table in
    /// [Statistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Statistic) in the *Amazon CloudWatch User Guide*.
    ///
    /// The most commonly used metric for scaling is `Average`.
    stat: []const u8,

    /// The unit to use for the returned data points. For a complete list of the
    /// units that
    /// CloudWatch supports, see the
    /// [MetricDatum](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_MetricDatum.html)
    /// data type in the *Amazon CloudWatch API Reference*.
    unit: ?[]const u8 = null,
};
