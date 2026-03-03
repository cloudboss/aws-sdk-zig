const ECSServiceProjectedMetric = @import("ecs_service_projected_metric.zig").ECSServiceProjectedMetric;

/// Describes the projected metrics of an Amazon ECS service recommendation
/// option.
///
/// To determine the performance difference between your current Amazon ECS
/// service and the recommended option,
/// compare the metric data of your service against its projected metric data.
pub const ECSServiceRecommendedOptionProjectedMetric = struct {
    /// An array of objects that describe the projected metric.
    projected_metrics: ?[]const ECSServiceProjectedMetric = null,

    /// The recommended CPU size for the Amazon ECS service.
    recommended_cpu_units: i32 = 0,

    /// The recommended memory size for the Amazon ECS service.
    recommended_memory_size: i32 = 0,

    pub const json_field_names = .{
        .projected_metrics = "projectedMetrics",
        .recommended_cpu_units = "recommendedCpuUnits",
        .recommended_memory_size = "recommendedMemorySize",
    };
};
