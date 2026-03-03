const CustomizedScalingMetricSpecification = @import("customized_scaling_metric_specification.zig").CustomizedScalingMetricSpecification;
const PredefinedScalingMetricSpecification = @import("predefined_scaling_metric_specification.zig").PredefinedScalingMetricSpecification;

/// Describes a target tracking configuration to use with AWS Auto Scaling. Used
/// with ScalingInstruction and ScalingPolicy.
pub const TargetTrackingConfiguration = struct {
    /// A customized metric. You can specify either a predefined metric or a
    /// customized metric.
    customized_scaling_metric_specification: ?CustomizedScalingMetricSpecification = null,

    /// Indicates whether scale in by the target tracking scaling policy is
    /// disabled. If the
    /// value is `true`, scale in is disabled and the target tracking scaling policy
    /// doesn't remove capacity from the scalable resource. Otherwise, scale in is
    /// enabled and the
    /// target tracking scaling policy can remove capacity from the scalable
    /// resource.
    ///
    /// The default value is `false`.
    disable_scale_in: ?bool = null,

    /// The estimated time, in seconds, until a newly launched instance can
    /// contribute to the
    /// CloudWatch metrics. This value is used only if the resource is an Auto
    /// Scaling group.
    estimated_instance_warmup: ?i32 = null,

    /// A predefined metric. You can specify either a predefined metric or a
    /// customized
    /// metric.
    predefined_scaling_metric_specification: ?PredefinedScalingMetricSpecification = null,

    /// The amount of time, in seconds, after a scale-in activity completes before
    /// another
    /// scale-in activity can start. This property is not used if the scalable
    /// resource is an Auto Scaling
    /// group.
    ///
    /// With the *scale-in cooldown period*, the intention is to scale in
    /// conservatively to protect your application’s availability, so scale-in
    /// activities are blocked
    /// until the cooldown period has expired. However, if another alarm triggers a
    /// scale-out activity
    /// during the scale-in cooldown period, Auto Scaling scales out the target
    /// immediately. In this case,
    /// the scale-in cooldown period stops and doesn't complete.
    scale_in_cooldown: ?i32 = null,

    /// The amount of time, in seconds, to wait for a previous scale-out activity to
    /// take
    /// effect. This property is not used if the scalable resource is an Auto
    /// Scaling
    /// group.
    ///
    /// With the *scale-out cooldown period*, the intention is to continuously
    /// (but not excessively) scale out. After Auto Scaling successfully scales out
    /// using a target
    /// tracking scaling policy, it starts to calculate the cooldown time. The
    /// scaling policy won't
    /// increase the desired capacity again unless either a larger scale out is
    /// triggered or the
    /// cooldown period ends.
    scale_out_cooldown: ?i32 = null,

    /// The target value for the metric. Although this property accepts numbers of
    /// type Double,
    /// it won't accept values that are either too small or too large. Values must
    /// be in the range
    /// of -2^360 to 2^360.
    target_value: f64,

    pub const json_field_names = .{
        .customized_scaling_metric_specification = "CustomizedScalingMetricSpecification",
        .disable_scale_in = "DisableScaleIn",
        .estimated_instance_warmup = "EstimatedInstanceWarmup",
        .predefined_scaling_metric_specification = "PredefinedScalingMetricSpecification",
        .scale_in_cooldown = "ScaleInCooldown",
        .scale_out_cooldown = "ScaleOutCooldown",
        .target_value = "TargetValue",
    };
};
