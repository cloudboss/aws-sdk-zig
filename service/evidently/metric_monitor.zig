const MetricDefinition = @import("metric_definition.zig").MetricDefinition;

/// A structure that defines a metric to be used to monitor performance of the
/// variations during a launch.
pub const MetricMonitor = struct {
    /// A structure that defines the metric.
    metric_definition: MetricDefinition,

    pub const json_field_names = .{
        .metric_definition = "metricDefinition",
    };
};
