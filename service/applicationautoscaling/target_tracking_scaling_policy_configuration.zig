const CustomizedMetricSpecification = @import("customized_metric_specification.zig").CustomizedMetricSpecification;
const PredefinedMetricSpecification = @import("predefined_metric_specification.zig").PredefinedMetricSpecification;

/// Represents a target tracking scaling policy configuration to use with
/// Application Auto Scaling.
///
/// For more information, see [Target tracking scaling
/// policies](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-target-tracking.html) in the
/// *Application Auto Scaling User Guide*.
pub const TargetTrackingScalingPolicyConfiguration = struct {
    /// A customized metric. You can specify either a predefined metric or a
    /// customized
    /// metric.
    customized_metric_specification: ?CustomizedMetricSpecification,

    /// Indicates whether scale in by the target tracking scaling policy is
    /// disabled. If the
    /// value is `true`, scale in is disabled and the target tracking scaling policy
    /// won't remove capacity from the scalable target. Otherwise, scale in is
    /// enabled and the
    /// target tracking scaling policy can remove capacity from the scalable target.
    /// The default
    /// value is `false`.
    disable_scale_in: ?bool,

    /// A predefined metric. You can specify either a predefined metric or a
    /// customized
    /// metric.
    predefined_metric_specification: ?PredefinedMetricSpecification,

    /// The amount of time, in seconds, after a scale-in activity completes before
    /// another
    /// scale-in activity can start. For more information and for default values,
    /// see [Define cooldown
    /// periods](https://docs.aws.amazon.com/autoscaling/application/userguide/target-tracking-scaling-policy-overview.html#target-tracking-cooldown) in the *Application Auto Scaling User Guide*.
    scale_in_cooldown: ?i32,

    /// The amount of time, in seconds, to wait for a previous scale-out activity to
    /// take effect.
    /// For more information and for default values, see [Define cooldown
    /// periods](https://docs.aws.amazon.com/autoscaling/application/userguide/target-tracking-scaling-policy-overview.html#target-tracking-cooldown) in the *Application Auto Scaling User Guide*.
    scale_out_cooldown: ?i32,

    /// The target value for the metric. Although this property accepts numbers of
    /// type Double,
    /// it won't accept values that are either too small or too large. Values must
    /// be in the range
    /// of -2^360 to 2^360. The value must be a valid number based on the choice of
    /// metric. For
    /// example, if the metric is CPU utilization, then the target value is a
    /// percent value that
    /// represents how much of the CPU can be used before scaling out.
    ///
    /// If the scaling policy specifies the `ALBRequestCountPerTarget` predefined
    /// metric, specify the target utilization as the optimal average request count
    /// per target
    /// during any one-minute interval.
    target_value: f64,

    pub const json_field_names = .{
        .customized_metric_specification = "CustomizedMetricSpecification",
        .disable_scale_in = "DisableScaleIn",
        .predefined_metric_specification = "PredefinedMetricSpecification",
        .scale_in_cooldown = "ScaleInCooldown",
        .scale_out_cooldown = "ScaleOutCooldown",
        .target_value = "TargetValue",
    };
};
