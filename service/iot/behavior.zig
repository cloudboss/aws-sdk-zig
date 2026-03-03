const BehaviorCriteria = @import("behavior_criteria.zig").BehaviorCriteria;
const MetricDimension = @import("metric_dimension.zig").MetricDimension;

/// A Device Defender security profile behavior.
pub const Behavior = struct {
    /// The criteria that determine if a device is behaving normally in regard to
    /// the `metric`.
    ///
    /// In the IoT console, you can choose to be sent an alert through Amazon SNS
    /// when IoT Device Defender detects that a device is behaving anomalously.
    criteria: ?BehaviorCriteria = null,

    /// Value indicates exporting metrics related to the behavior when it is true.
    export_metric: ?bool = null,

    /// What is measured by the behavior.
    metric: ?[]const u8 = null,

    /// The dimension for a metric in your behavior. For example, using a
    /// `TOPIC_FILTER` dimension, you can narrow down the scope of the metric to
    /// only MQTT topics where the name matches the pattern specified in the
    /// dimension. This can't be used with custom metrics.
    metric_dimension: ?MetricDimension = null,

    /// The name
    /// you've given to the behavior.
    name: []const u8,

    /// Suppresses alerts.
    suppress_alerts: ?bool = null,

    pub const json_field_names = .{
        .criteria = "criteria",
        .export_metric = "exportMetric",
        .metric = "metric",
        .metric_dimension = "metricDimension",
        .name = "name",
        .suppress_alerts = "suppressAlerts",
    };
};
