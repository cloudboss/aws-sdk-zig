const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;
const Period = @import("period.zig").Period;
const XAxisType = @import("x_axis_type.zig").XAxisType;

/// Specifies a query to retrieve training metrics from SageMaker.
pub const MetricQuery = struct {
    /// The end time of metrics to retrieve.
    end: ?i64 = null,

    /// The name of the metric to retrieve.
    metric_name: []const u8,

    /// The metrics stat type of metrics to retrieve.
    metric_stat: MetricStatistic,

    /// The time period of metrics to retrieve.
    period: Period,

    /// The ARN of the SageMaker resource to retrieve metrics for.
    resource_arn: []const u8,

    /// The start time of metrics to retrieve.
    start: ?i64 = null,

    /// The x-axis type of metrics to retrieve.
    x_axis_type: XAxisType,

    pub const json_field_names = .{
        .end = "End",
        .metric_name = "MetricName",
        .metric_stat = "MetricStat",
        .period = "Period",
        .resource_arn = "ResourceArn",
        .start = "Start",
        .x_axis_type = "XAxisType",
    };
};
