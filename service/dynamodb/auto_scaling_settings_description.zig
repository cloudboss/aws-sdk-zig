const AutoScalingPolicyDescription = @import("auto_scaling_policy_description.zig").AutoScalingPolicyDescription;

/// Represents the auto scaling settings for a global table or global secondary
/// index.
pub const AutoScalingSettingsDescription = struct {
    /// Disabled auto scaling for this global table or global secondary index.
    auto_scaling_disabled: ?bool,

    /// Role ARN used for configuring the auto scaling policy.
    auto_scaling_role_arn: ?[]const u8,

    /// The maximum capacity units that a global table or global secondary index
    /// should be
    /// scaled up to.
    maximum_units: ?i64,

    /// The minimum capacity units that a global table or global secondary index
    /// should be
    /// scaled down to.
    minimum_units: ?i64,

    /// Information about the scaling policies.
    scaling_policies: ?[]const AutoScalingPolicyDescription,
};
