const ContinuousDeploymentPolicy = @import("continuous_deployment_policy.zig").ContinuousDeploymentPolicy;

/// A summary of the information about your continuous deployment policies.
pub const ContinuousDeploymentPolicySummary = struct {
    /// The continuous deployment policy.
    continuous_deployment_policy: ContinuousDeploymentPolicy,
};
