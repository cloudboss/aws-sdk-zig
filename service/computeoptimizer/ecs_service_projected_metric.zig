const ECSServiceMetricName = @import("ecs_service_metric_name.zig").ECSServiceMetricName;

/// Describes the projected metrics of an Amazon ECS service recommendation
/// option.
///
/// To determine the performance difference between your current Amazon ECS
/// service and the recommended option,
/// compare the metric data of your service against its projected metric data.
pub const ECSServiceProjectedMetric = struct {
    /// The lower bound values for the projected metric.
    lower_bound_values: ?[]const f64 = null,

    /// The name of the projected metric.
    ///
    /// The following metrics are available:
    ///
    /// * `Cpu` — The percentage of allocated compute units
    /// that are currently in use on the service tasks.
    ///
    /// * `Memory` — The percentage of memory that's
    /// currently in use on the service tasks.
    name: ?ECSServiceMetricName = null,

    /// The timestamps of the projected metric.
    timestamps: ?[]const i64 = null,

    /// The upper bound values for the projected metric.
    upper_bound_values: ?[]const f64 = null,

    pub const json_field_names = .{
        .lower_bound_values = "lowerBoundValues",
        .name = "name",
        .timestamps = "timestamps",
        .upper_bound_values = "upperBoundValues",
    };
};
