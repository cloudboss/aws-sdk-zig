const ScalingPolicy = @import("scaling_policy.zig").ScalingPolicy;

/// An object with the recommended values for you to specify when creating an
/// autoscaling policy.
pub const DynamicScalingConfiguration = struct {
    /// The recommended maximum capacity to specify for your autoscaling policy.
    max_capacity: ?i32 = null,

    /// The recommended minimum capacity to specify for your autoscaling policy.
    min_capacity: ?i32 = null,

    /// The recommended scale in cooldown time for your autoscaling policy.
    scale_in_cooldown: ?i32 = null,

    /// The recommended scale out cooldown time for your autoscaling policy.
    scale_out_cooldown: ?i32 = null,

    /// An object of the scaling policies for each metric.
    scaling_policies: ?[]const ScalingPolicy = null,

    pub const json_field_names = .{
        .max_capacity = "MaxCapacity",
        .min_capacity = "MinCapacity",
        .scale_in_cooldown = "ScaleInCooldown",
        .scale_out_cooldown = "ScaleOutCooldown",
        .scaling_policies = "ScalingPolicies",
    };
};
