const CapacityProviderPredefinedMetricType = @import("capacity_provider_predefined_metric_type.zig").CapacityProviderPredefinedMetricType;

/// A scaling policy for the capacity provider that automatically adjusts
/// capacity to maintain a target value for a specific metric.
pub const TargetTrackingScalingPolicy = struct {
    /// The predefined metric type to track for scaling decisions.
    predefined_metric_type: CapacityProviderPredefinedMetricType,

    /// The target value for the metric that the scaling policy attempts to maintain
    /// through scaling actions.
    target_value: f64,

    pub const json_field_names = .{
        .predefined_metric_type = "PredefinedMetricType",
        .target_value = "TargetValue",
    };
};
