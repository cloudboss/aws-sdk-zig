const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const MetricDimension = @import("metric_dimension.zig").MetricDimension;
const Statistic = @import("statistic.zig").Statistic;
const Unit = @import("unit.zig").Unit;

/// The definition of a CloudWatch metric alarm, which determines when an
/// automatic scaling
/// activity is triggered. When the defined alarm conditions are satisfied,
/// scaling activity
/// begins.
pub const CloudWatchAlarmDefinition = struct {
    /// Determines how the metric specified by `MetricName` is compared to the value
    /// specified by `Threshold`.
    comparison_operator: ComparisonOperator,

    /// A CloudWatch metric dimension.
    dimensions: ?[]const MetricDimension,

    /// The number of periods, in five-minute increments, during which the alarm
    /// condition must
    /// exist before the alarm triggers automatic scaling activity. The default
    /// value is
    /// `1`.
    evaluation_periods: ?i32,

    /// The name of the CloudWatch metric that is watched to determine an alarm
    /// condition.
    metric_name: []const u8,

    /// The namespace for the CloudWatch metric. The default is
    /// `AWS/ElasticMapReduce`.
    namespace: ?[]const u8,

    /// The period, in seconds, over which the statistic is applied. CloudWatch
    /// metrics for
    /// Amazon EMR are emitted every five minutes (300 seconds), so if you specify a
    /// CloudWatch metric, specify `300`.
    period: i32,

    /// The statistic to apply to the metric associated with the alarm. The default
    /// is
    /// `AVERAGE`.
    statistic: ?Statistic,

    /// The value against which the specified statistic is compared.
    threshold: f64,

    /// The unit of measure associated with the CloudWatch metric being watched. The
    /// value
    /// specified for `Unit` must correspond to the units specified in the
    /// CloudWatch
    /// metric.
    unit: ?Unit,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .dimensions = "Dimensions",
        .evaluation_periods = "EvaluationPeriods",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .period = "Period",
        .statistic = "Statistic",
        .threshold = "Threshold",
        .unit = "Unit",
    };
};
