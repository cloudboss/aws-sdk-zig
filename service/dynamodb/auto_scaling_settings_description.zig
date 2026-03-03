const AutoScalingPolicyDescription = @import("auto_scaling_policy_description.zig").AutoScalingPolicyDescription;

/// Represents the auto scaling settings for a global table or global secondary
/// index.
pub const AutoScalingSettingsDescription = struct {
    /// Disabled auto scaling for this global table or global secondary index.
    auto_scaling_disabled: ?bool = null,

    /// Role ARN used for configuring the auto scaling policy.
    auto_scaling_role_arn: ?[]const u8 = null,

    /// The maximum capacity units that a global table or global secondary index
    /// should be
    /// scaled up to.
    maximum_units: ?i64 = null,

    /// The minimum capacity units that a global table or global secondary index
    /// should be
    /// scaled down to.
    minimum_units: ?i64 = null,

    /// Information about the scaling policies.
    scaling_policies: ?[]const AutoScalingPolicyDescription = null,

    pub const json_field_names = .{
        .auto_scaling_disabled = "AutoScalingDisabled",
        .auto_scaling_role_arn = "AutoScalingRoleArn",
        .maximum_units = "MaximumUnits",
        .minimum_units = "MinimumUnits",
        .scaling_policies = "ScalingPolicies",
    };
};
