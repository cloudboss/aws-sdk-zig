const FleetScalingMetricType = @import("fleet_scaling_metric_type.zig").FleetScalingMetricType;

/// Defines when a new instance is auto-scaled into the compute fleet.
pub const TargetTrackingScalingConfiguration = struct {
    /// The metric type to determine auto-scaling.
    metric_type: ?FleetScalingMetricType = null,

    /// The value of `metricType` when to start scaling.
    target_value: ?f64 = null,

    pub const json_field_names = .{
        .metric_type = "metricType",
        .target_value = "targetValue",
    };
};
