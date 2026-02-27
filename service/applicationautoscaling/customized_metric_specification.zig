const MetricDimension = @import("metric_dimension.zig").MetricDimension;
const TargetTrackingMetricDataQuery = @import("target_tracking_metric_data_query.zig").TargetTrackingMetricDataQuery;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;

/// Represents a CloudWatch metric of your choosing for a target tracking
/// scaling policy to use
/// with Application Auto Scaling.
///
/// For information about the available metrics for a service, see [Amazon Web
/// Services
/// services that publish CloudWatch
/// metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html) in the *Amazon CloudWatch User
/// Guide*.
///
/// To create your customized metric specification:
///
/// * Add values for each required parameter from CloudWatch. You can use an
///   existing metric,
/// or a new metric that you create. To use your own metric, you must first
/// publish the
/// metric to CloudWatch. For more information, see [Publish custom
/// metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html) in the *Amazon CloudWatch User Guide*.
///
/// * Choose a metric that changes proportionally with capacity. The value of
///   the metric
/// should increase or decrease in inverse proportion to the number of capacity
/// units.
/// That is, the value of the metric should decrease when capacity increases,
/// and
/// increase when capacity decreases.
///
/// For more information about the CloudWatch terminology below, see [Amazon
/// CloudWatch
/// concepts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html) in the *Amazon CloudWatch User Guide*.
pub const CustomizedMetricSpecification = struct {
    /// The dimensions of the metric.
    ///
    /// Conditional: If you published your metric with dimensions, you must specify
    /// the same
    /// dimensions in your scaling policy.
    dimensions: ?[]const MetricDimension,

    /// The name of the metric. To get the exact metric name, namespace, and
    /// dimensions, inspect
    /// the
    /// [Metric](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_Metric.html) object that's returned by a call to [ListMetrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_ListMetrics.html).
    metric_name: ?[]const u8,

    /// The metrics to include in the target tracking scaling policy, as a metric
    /// data query.
    /// This can include both raw metric and metric math expressions.
    metrics: ?[]const TargetTrackingMetricDataQuery,

    /// The namespace of the metric.
    namespace: ?[]const u8,

    /// The statistic of the metric.
    statistic: ?MetricStatistic,

    /// The unit of the metric. For a complete list of the units that CloudWatch
    /// supports, see the
    /// [MetricDatum](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_MetricDatum.html) data
    /// type in the *Amazon CloudWatch API Reference*.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .metric_name = "MetricName",
        .metrics = "Metrics",
        .namespace = "Namespace",
        .statistic = "Statistic",
        .unit = "Unit",
    };
};
