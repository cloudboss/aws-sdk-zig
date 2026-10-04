const MetricConfiguration = @import("metric_configuration.zig").MetricConfiguration;

/// The optional monitoring configuration for a service, which defines the
/// resolution for the service-level `CPUUtilization` and `MemoryUtilization`
/// Amazon CloudWatch metrics. When not specified, Amazon ECS uses the default
/// resolution of `60` seconds.
pub const MonitoringConfiguration = struct {
    /// The list of metric configurations for the service monitoring.
    metric_configurations: ?[]const MetricConfiguration = null,

    pub const json_field_names = .{
        .metric_configurations = "metricConfigurations",
    };
};
