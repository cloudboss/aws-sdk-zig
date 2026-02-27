const MetricDefinitionConfig = @import("metric_definition_config.zig").MetricDefinitionConfig;

/// A structure that defines a metric to be used to monitor performance of the
/// variations during a launch.
pub const MetricMonitorConfig = struct {
    /// A structure that defines the metric.
    metric_definition: MetricDefinitionConfig,

    pub const json_field_names = .{
        .metric_definition = "metricDefinition",
    };
};
