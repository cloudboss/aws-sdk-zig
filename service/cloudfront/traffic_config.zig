const ContinuousDeploymentSingleHeaderConfig = @import("continuous_deployment_single_header_config.zig").ContinuousDeploymentSingleHeaderConfig;
const ContinuousDeploymentSingleWeightConfig = @import("continuous_deployment_single_weight_config.zig").ContinuousDeploymentSingleWeightConfig;
const ContinuousDeploymentPolicyType = @import("continuous_deployment_policy_type.zig").ContinuousDeploymentPolicyType;

/// The traffic configuration of your continuous deployment.
pub const TrafficConfig = struct {
    /// Determines which HTTP requests are sent to the staging distribution.
    single_header_config: ?ContinuousDeploymentSingleHeaderConfig = null,

    /// Contains the percentage of traffic to send to the staging distribution.
    single_weight_config: ?ContinuousDeploymentSingleWeightConfig = null,

    /// The type of traffic configuration.
    @"type": ContinuousDeploymentPolicyType,
};
