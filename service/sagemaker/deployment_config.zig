const AutoRollbackConfig = @import("auto_rollback_config.zig").AutoRollbackConfig;
const BlueGreenUpdatePolicy = @import("blue_green_update_policy.zig").BlueGreenUpdatePolicy;
const RollingUpdatePolicy = @import("rolling_update_policy.zig").RollingUpdatePolicy;

/// The deployment configuration for an endpoint, which contains the desired
/// deployment strategy and rollback configurations.
pub const DeploymentConfig = struct {
    /// Automatic rollback configuration for handling endpoint deployment failures
    /// and recovery.
    auto_rollback_configuration: ?AutoRollbackConfig,

    /// Update policy for a blue/green deployment. If this update policy is
    /// specified, SageMaker creates a new fleet during the deployment while
    /// maintaining the old fleet. SageMaker flips traffic to the new fleet
    /// according to the specified traffic routing configuration. Only one update
    /// policy should be used in the deployment configuration. If no update policy
    /// is specified, SageMaker uses a blue/green deployment strategy with all at
    /// once traffic shifting by default.
    blue_green_update_policy: ?BlueGreenUpdatePolicy,

    /// Specifies a rolling deployment strategy for updating a SageMaker endpoint.
    rolling_update_policy: ?RollingUpdatePolicy,

    pub const json_field_names = .{
        .auto_rollback_configuration = "AutoRollbackConfiguration",
        .blue_green_update_policy = "BlueGreenUpdatePolicy",
        .rolling_update_policy = "RollingUpdatePolicy",
    };
};
