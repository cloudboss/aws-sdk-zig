const Metric = @import("metric.zig").Metric;

/// This structure defines the CloudWatch metric to return, along with the
/// statistic and
/// unit.
///
/// For more information about the CloudWatch terminology below, see [Amazon
/// CloudWatch
/// concepts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html) in the *Amazon CloudWatch User Guide*.
pub const MetricStat = struct {
    /// The CloudWatch metric to return, including the metric name, namespace, and
    /// dimensions. To
    /// get the exact metric name, namespace, and dimensions, inspect the
    /// [Metric](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_Metric.html) object that is returned by a call to [ListMetrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_ListMetrics.html).
    metric: Metric,

    /// The statistic to return. It can include any CloudWatch statistic or extended
    /// statistic. For
    /// a list of valid values, see the table in
    /// [Statistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Statistic) in the *Amazon CloudWatch User Guide*.
    ///
    /// The most commonly used metrics for predictive scaling are `Average` and
    /// `Sum`.
    stat: []const u8,

    /// The unit to use for the returned data points. For a complete list of the
    /// units that
    /// CloudWatch supports, see the
    /// [MetricDatum](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_MetricDatum.html)
    /// data type in the *Amazon CloudWatch API Reference*.
    unit: ?[]const u8 = null,
};
