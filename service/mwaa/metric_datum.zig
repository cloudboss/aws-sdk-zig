const Dimension = @import("dimension.zig").Dimension;
const StatisticSet = @import("statistic_set.zig").StatisticSet;
const Unit = @import("unit.zig").Unit;

/// **Internal only**. Collects Apache Airflow metrics. To learn more about the
/// metrics published to Amazon CloudWatch, see [Amazon MWAA performance metrics
/// in Amazon
/// CloudWatch](https://docs.aws.amazon.com/mwaa/latest/userguide/cw-metrics.html).
pub const MetricDatum = struct {
    /// **Internal only**. The dimensions associated with the metric.
    dimensions: ?[]const Dimension = null,

    /// **Internal only**. The name of the metric.
    metric_name: []const u8,

    /// **Internal only**. The statistical values for the metric.
    statistic_values: ?StatisticSet = null,

    /// **Internal only**. The time the metric data was received.
    timestamp: i64,

    /// **Internal only**. The unit used to store the metric.
    unit: ?Unit = null,

    /// **Internal only**. The value for the metric.
    value: ?f64 = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .metric_name = "MetricName",
        .statistic_values = "StatisticValues",
        .timestamp = "Timestamp",
        .unit = "Unit",
        .value = "Value",
    };
};
