const AutoScalingTargetTrackingScalingPolicyConfigurationDescription = @import("auto_scaling_target_tracking_scaling_policy_configuration_description.zig").AutoScalingTargetTrackingScalingPolicyConfigurationDescription;

/// Represents the properties of the scaling policy.
pub const AutoScalingPolicyDescription = struct {
    /// The name of the scaling policy.
    policy_name: ?[]const u8,

    /// Represents a target tracking scaling policy configuration.
    target_tracking_scaling_policy_configuration: ?AutoScalingTargetTrackingScalingPolicyConfigurationDescription,

    pub const json_field_names = .{
        .policy_name = "PolicyName",
        .target_tracking_scaling_policy_configuration = "TargetTrackingScalingPolicyConfiguration",
    };
};
