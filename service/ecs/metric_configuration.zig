/// The configuration for a specific set of metrics to collect for a service.
pub const MetricConfiguration = struct {
    /// The list of metric names to configure. The supported metric names are
    /// `CPUUtilization` and `MemoryUtilization`.
    metric_names: []const []const u8,

    /// The resolution, in seconds, at which to collect the metrics. The valid
    /// values are `20` and `60`.
    resolution_seconds: i32,

    pub const json_field_names = .{
        .metric_names = "metricNames",
        .resolution_seconds = "resolutionSeconds",
    };
};
