const ContinuousDeploymentPolicyConfig = @import("continuous_deployment_policy_config.zig").ContinuousDeploymentPolicyConfig;

/// A continuous deployment policy.
pub const ContinuousDeploymentPolicy = struct {
    continuous_deployment_policy_config: ContinuousDeploymentPolicyConfig,

    /// The identifier of the continuous deployment policy.
    id: []const u8,

    /// The date and time the continuous deployment policy was last modified.
    last_modified_time: i64,
};
