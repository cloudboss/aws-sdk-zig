const MetricDimension = @import("metric_dimension.zig").MetricDimension;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;

/// Represents a CloudWatch metric of your choosing that can be used for dynamic
/// scaling as part
/// of a target tracking scaling policy.
///
/// To create your customized scaling metric specification:
///
/// * Add values for each required parameter from CloudWatch. You can use an
///   existing metric,
/// or a new metric that you create. To use your own metric, you must first
/// publish the
/// metric to CloudWatch. For more information, see [Publish Custom
/// Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html) in the *Amazon CloudWatch User Guide*.
///
/// * Choose a metric that changes proportionally with capacity. The value of
///   the metric
/// should increase or decrease in inverse proportion to the number of capacity
/// units.
/// That is, the value of the metric should decrease when capacity increases.
///
/// For information about terminology, available metrics, or how to publish new
/// metrics, see
/// [Amazon CloudWatch
/// Concepts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html) in the *Amazon CloudWatch User Guide*.
pub const CustomizedScalingMetricSpecification = struct {
    /// The dimensions of the metric.
    ///
    /// Conditional: If you published your metric with dimensions, you must specify
    /// the same
    /// dimensions in your customized scaling metric specification.
    dimensions: ?[]const MetricDimension = null,

    /// The name of the metric.
    metric_name: []const u8,

    /// The namespace of the metric.
    namespace: []const u8,

    /// The statistic of the metric.
    statistic: MetricStatistic,

    /// The unit of the metric.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .statistic = "Statistic",
        .unit = "Unit",
    };
};
