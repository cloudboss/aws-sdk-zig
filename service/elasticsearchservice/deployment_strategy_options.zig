const DeploymentStrategy = @import("deployment_strategy.zig").DeploymentStrategy;

/// Specifies the deployment strategy options for the domain.
pub const DeploymentStrategyOptions = struct {
    /// Specifies the deployment strategy for the domain. Valid values are `Default`
    /// and `CapacityOptimized`.
    deployment_strategy: DeploymentStrategy,

    pub const json_field_names = .{
        .deployment_strategy = "DeploymentStrategy",
    };
};
