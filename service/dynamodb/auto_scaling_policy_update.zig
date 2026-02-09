const AutoScalingTargetTrackingScalingPolicyConfigurationUpdate = @import("auto_scaling_target_tracking_scaling_policy_configuration_update.zig").AutoScalingTargetTrackingScalingPolicyConfigurationUpdate;

/// Represents the auto scaling policy to be modified.
pub const AutoScalingPolicyUpdate = struct {
    /// The name of the scaling policy.
    policy_name: ?[]const u8,

    /// Represents a target tracking scaling policy configuration.
    target_tracking_scaling_policy_configuration: AutoScalingTargetTrackingScalingPolicyConfigurationUpdate,
};
