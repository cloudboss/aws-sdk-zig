const DeploymentComponentUpdatePolicy = @import("deployment_component_update_policy.zig").DeploymentComponentUpdatePolicy;
const DeploymentConfigurationValidationPolicy = @import("deployment_configuration_validation_policy.zig").DeploymentConfigurationValidationPolicy;
const DeploymentFailureHandlingPolicy = @import("deployment_failure_handling_policy.zig").DeploymentFailureHandlingPolicy;

/// Contains information about policies that define how a deployment updates
/// components and
/// handles failure.
pub const DeploymentPolicies = struct {
    /// The component update policy for the configuration deployment. This policy
    /// defines when
    /// it's safe to deploy the configuration to devices.
    component_update_policy: ?DeploymentComponentUpdatePolicy,

    /// The configuration validation policy for the configuration deployment. This
    /// policy defines
    /// how long each component has to validate its configure updates.
    configuration_validation_policy: ?DeploymentConfigurationValidationPolicy,

    /// The failure handling policy for the configuration deployment. This policy
    /// defines what to
    /// do if the deployment fails.
    ///
    /// Default: `ROLLBACK`
    failure_handling_policy: ?DeploymentFailureHandlingPolicy,

    pub const json_field_names = .{
        .component_update_policy = "componentUpdatePolicy",
        .configuration_validation_policy = "configurationValidationPolicy",
        .failure_handling_policy = "failureHandlingPolicy",
    };
};
