const ExpressGatewayServiceScalingMetric = @import("express_gateway_service_scaling_metric.zig").ExpressGatewayServiceScalingMetric;

/// Defines the auto-scaling configuration for an Express service. This
/// determines how the
/// service automatically adjusts the number of running tasks based on demand
/// metrics such as
/// CPU utilization, memory utilization, or request count per target.
///
/// Auto-scaling helps ensure your application can handle varying levels of
/// traffic while
/// optimizing costs by scaling down during low-demand periods. You can specify
/// the minimum and
/// maximum number of tasks, the scaling metric, and the target value for that
/// metric.
pub const ExpressGatewayScalingTarget = struct {
    /// The metric used for auto-scaling decisions. The default metric used for an
    /// Express service is `CPUUtilization`.
    auto_scaling_metric: ?ExpressGatewayServiceScalingMetric,

    /// The target value for the auto-scaling metric. The default value for an
    /// Express service is 60.
    auto_scaling_target_value: ?i32,

    /// The maximum number of tasks to run in the Express service.
    max_task_count: ?i32,

    /// The minimum number of tasks to run in the Express service.
    min_task_count: ?i32,

    pub const json_field_names = .{
        .auto_scaling_metric = "autoScalingMetric",
        .auto_scaling_target_value = "autoScalingTargetValue",
        .max_task_count = "maxTaskCount",
        .min_task_count = "minTaskCount",
    };
};
