const TargetTrackingScalingPolicyConfiguration = @import("target_tracking_scaling_policy_configuration.zig").TargetTrackingScalingPolicyConfiguration;

/// Amazon Keyspaces supports the `target tracking` auto scaling policy. With
/// this policy, Amazon Keyspaces auto scaling ensures that the table's ratio of
/// consumed to provisioned capacity stays at or near the target value that you
/// specify. You define the target value as a percentage between 20 and 90.
pub const AutoScalingPolicy = struct {
    /// Auto scaling scales up capacity automatically when traffic exceeds this
    /// target utilization rate, and then back down when it falls below the target.
    /// A `double` between 20 and 90.
    target_tracking_scaling_policy_configuration: ?TargetTrackingScalingPolicyConfiguration = null,

    pub const json_field_names = .{
        .target_tracking_scaling_policy_configuration = "targetTrackingScalingPolicyConfiguration",
    };
};
