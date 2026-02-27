const AdjustmentType = @import("adjustment_type.zig").AdjustmentType;
const MetricAggregationType = @import("metric_aggregation_type.zig").MetricAggregationType;
const StepAdjustment = @import("step_adjustment.zig").StepAdjustment;

/// Represents a step scaling policy configuration to use with Application Auto
/// Scaling.
///
/// For more information, see [Step scaling
/// policies](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-step-scaling-policies.html) in the *Application Auto Scaling User Guide*.
pub const StepScalingPolicyConfiguration = struct {
    /// Specifies how the `ScalingAdjustment` value in a
    /// [StepAdjustment](https://docs.aws.amazon.com/autoscaling/application/APIReference/API_StepAdjustment.html) is interpreted (for example, an absolute number or a
    /// percentage). The valid values are `ChangeInCapacity`,
    /// `ExactCapacity`, and `PercentChangeInCapacity`.
    ///
    /// `AdjustmentType` is required if you are adding a new step scaling policy
    /// configuration.
    adjustment_type: ?AdjustmentType,

    /// The amount of time, in seconds, to wait for a previous scaling activity to
    /// take effect. If
    /// not specified, the default value is 300. For more information, see [Cooldown
    /// period](https://docs.aws.amazon.com/autoscaling/application/userguide/step-scaling-policy-overview.html#step-scaling-cooldown) in the *Application Auto Scaling User Guide*.
    cooldown: ?i32,

    /// The aggregation type for the CloudWatch metrics. Valid values are `Minimum`,
    /// `Maximum`, and `Average`. If the aggregation type is null, the
    /// value is treated as `Average`.
    metric_aggregation_type: ?MetricAggregationType,

    /// The minimum value to scale by when the adjustment type is
    /// `PercentChangeInCapacity`. For example, suppose that you create a step
    /// scaling policy to scale out an Amazon ECS service by 25 percent and you
    /// specify a
    /// `MinAdjustmentMagnitude` of 2. If the service has 4 tasks and the scaling
    /// policy is performed, 25 percent of 4 is 1. However, because you specified a
    /// `MinAdjustmentMagnitude` of 2, Application Auto Scaling scales out the
    /// service by 2
    /// tasks.
    min_adjustment_magnitude: ?i32,

    /// A set of adjustments that enable you to scale based on the size of the alarm
    /// breach.
    ///
    /// At least one step adjustment is required if you are adding a new step
    /// scaling policy
    /// configuration.
    step_adjustments: ?[]const StepAdjustment,

    pub const json_field_names = .{
        .adjustment_type = "AdjustmentType",
        .cooldown = "Cooldown",
        .metric_aggregation_type = "MetricAggregationType",
        .min_adjustment_magnitude = "MinAdjustmentMagnitude",
        .step_adjustments = "StepAdjustments",
    };
};
