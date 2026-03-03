const Alarm = @import("alarm.zig").Alarm;
const PredictiveScalingConfiguration = @import("predictive_scaling_configuration.zig").PredictiveScalingConfiguration;
const StepAdjustment = @import("step_adjustment.zig").StepAdjustment;
const TargetTrackingConfiguration = @import("target_tracking_configuration.zig").TargetTrackingConfiguration;

/// Describes a scaling policy.
pub const ScalingPolicy = struct {
    /// Specifies how the scaling adjustment is interpreted (for example, an
    /// absolute number
    /// or a percentage). The valid values are `ChangeInCapacity`,
    /// `ExactCapacity`, and `PercentChangeInCapacity`.
    adjustment_type: ?[]const u8 = null,

    /// The CloudWatch alarms related to the policy.
    alarms: ?[]const Alarm = null,

    /// The name of the Auto Scaling group.
    auto_scaling_group_name: ?[]const u8 = null,

    /// The duration of the policy's cooldown period, in seconds.
    cooldown: ?i32 = null,

    /// Indicates whether the policy is enabled (`true`) or disabled
    /// (`false`).
    enabled: ?bool = null,

    /// The estimated time, in seconds, until a newly launched instance can
    /// contribute to the
    /// CloudWatch metrics.
    estimated_instance_warmup: ?i32 = null,

    /// The aggregation type for the CloudWatch metrics. The valid values are
    /// `Minimum`,
    /// `Maximum`, and `Average`.
    metric_aggregation_type: ?[]const u8 = null,

    /// The minimum value to scale by when the adjustment type is
    /// `PercentChangeInCapacity`.
    min_adjustment_magnitude: ?i32 = null,

    /// Available for backward compatibility. Use `MinAdjustmentMagnitude`
    /// instead.
    min_adjustment_step: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: ?[]const u8 = null,

    /// The name of the scaling policy.
    policy_name: ?[]const u8 = null,

    /// One of the following policy types:
    ///
    /// * `TargetTrackingScaling`
    ///
    /// * `StepScaling`
    ///
    /// * `SimpleScaling` (default)
    ///
    /// * `PredictiveScaling`
    ///
    /// For more information, see [Target tracking
    /// scaling
    /// policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-target-tracking.html) and [Step and simple scaling
    /// policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html) in the *Amazon EC2 Auto Scaling User Guide*.
    policy_type: ?[]const u8 = null,

    /// A predictive scaling policy.
    predictive_scaling_configuration: ?PredictiveScalingConfiguration = null,

    /// The amount by which to scale, based on the specified adjustment type. A
    /// positive value
    /// adds to the current capacity while a negative number removes from the
    /// current
    /// capacity.
    scaling_adjustment: ?i32 = null,

    /// A set of adjustments that enable you to scale based on the size of the alarm
    /// breach.
    step_adjustments: ?[]const StepAdjustment = null,

    /// A target tracking scaling policy.
    target_tracking_configuration: ?TargetTrackingConfiguration = null,
};
