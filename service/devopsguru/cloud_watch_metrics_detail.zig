const CloudWatchMetricsDimension = @import("cloud_watch_metrics_dimension.zig").CloudWatchMetricsDimension;
const CloudWatchMetricsDataSummary = @import("cloud_watch_metrics_data_summary.zig").CloudWatchMetricsDataSummary;
const CloudWatchMetricsStat = @import("cloud_watch_metrics_stat.zig").CloudWatchMetricsStat;

/// Information about an Amazon CloudWatch metric.
pub const CloudWatchMetricsDetail = struct {
    /// An array of CloudWatch dimensions associated with
    dimensions: ?[]const CloudWatchMetricsDimension,

    /// This object returns anomaly metric data.
    metric_data_summary: ?CloudWatchMetricsDataSummary,

    /// The name of the CloudWatch metric.
    metric_name: ?[]const u8,

    /// The namespace of the CloudWatch metric. A namespace is a container for
    /// CloudWatch metrics.
    namespace: ?[]const u8,

    /// The length of time associated with the CloudWatch metric in number of
    /// seconds.
    period: i32 = 0,

    /// The type of statistic associated with the CloudWatch metric. For more
    /// information, see
    /// [Statistics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Statistic) in the *Amazon CloudWatch User Guide*.
    stat: ?CloudWatchMetricsStat,

    /// The unit of measure used for the CloudWatch metric. For example, `Bytes`,
    /// `Seconds`, `Count`, and `Percent`.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .metric_data_summary = "MetricDataSummary",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .period = "Period",
        .stat = "Stat",
        .unit = "Unit",
    };
};
