const AdjustmentType = @import("adjustment_type.zig").AdjustmentType;

/// An automatic scaling configuration, which describes how the policy adds or
/// removes
/// instances, the cooldown period, and the number of Amazon EC2 instances that
/// will be
/// added each time the CloudWatch metric alarm condition is satisfied.
pub const SimpleScalingPolicyConfiguration = struct {
    /// The way in which Amazon EC2 instances are added (if
    /// `ScalingAdjustment` is a positive number) or terminated (if
    /// `ScalingAdjustment` is a negative number) each time the scaling activity is
    /// triggered. `CHANGE_IN_CAPACITY` is the default. `CHANGE_IN_CAPACITY`
    /// indicates that the Amazon EC2 instance count increments or decrements by
    /// `ScalingAdjustment`, which should be expressed as an integer.
    /// `PERCENT_CHANGE_IN_CAPACITY` indicates the instance count increments or
    /// decrements by the percentage specified by `ScalingAdjustment`, which should
    /// be
    /// expressed as an integer. For example, 20 indicates an increase in 20%
    /// increments of cluster
    /// capacity. `EXACT_CAPACITY` indicates the scaling activity results in an
    /// instance
    /// group with the number of Amazon EC2 instances specified by
    /// `ScalingAdjustment`, which should be expressed as a positive integer.
    adjustment_type: ?AdjustmentType = null,

    /// The amount of time, in seconds, after a scaling activity completes before
    /// any further
    /// trigger-related scaling activities can start. The default value is 0.
    cool_down: ?i32 = null,

    /// The amount by which to scale in or scale out, based on the specified
    /// `AdjustmentType`. A positive value adds to the instance group's Amazon EC2
    /// instance count while a negative number removes instances. If
    /// `AdjustmentType` is set to `EXACT_CAPACITY`, the number should
    /// only be a positive integer. If `AdjustmentType` is set to
    /// `PERCENT_CHANGE_IN_CAPACITY`, the value should express the percentage as an
    /// integer. For example, -20 indicates a decrease in 20% increments of cluster
    /// capacity.
    scaling_adjustment: i32,

    pub const json_field_names = .{
        .adjustment_type = "AdjustmentType",
        .cool_down = "CoolDown",
        .scaling_adjustment = "ScalingAdjustment",
    };
};
