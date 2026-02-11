const LambdaManagedInstancesCapacityProviderConfig = @import("lambda_managed_instances_capacity_provider_config.zig").LambdaManagedInstancesCapacityProviderConfig;

/// Configuration for the capacity provider that manages compute resources for
/// Lambda functions.
pub const CapacityProviderConfig = struct {
    /// Configuration for Lambda-managed instances used by the capacity provider.
    lambda_managed_instances_capacity_provider_config: LambdaManagedInstancesCapacityProviderConfig,

    pub const json_field_names = .{
        .lambda_managed_instances_capacity_provider_config = "LambdaManagedInstancesCapacityProviderConfig",
    };
};
