const CurrentMetricName = @import("current_metric_name.zig").CurrentMetricName;
const Unit = @import("unit.zig").Unit;

/// Contains information about a real-time metric. For a description of each
/// metric, see [Metrics
/// definitions](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html) in the *Amazon Connect Administrator Guide*.
///
/// Only one of either the Name or MetricId is required.
pub const CurrentMetric = struct {
    /// Out of the box current metrics or custom metrics can be referenced via this
    /// field. This field is a valid AWS Connect Arn or a UUID.
    metric_id: ?[]const u8,

    /// The name of the metric.
    name: ?CurrentMetricName,

    /// The Unit parameter is not supported for custom metrics.
    ///
    /// The unit for the metric.
    unit: ?Unit,

    pub const json_field_names = .{
        .metric_id = "MetricId",
        .name = "Name",
        .unit = "Unit",
    };
};
