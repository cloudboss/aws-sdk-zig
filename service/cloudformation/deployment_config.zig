const DeploymentConfigMode = @import("deployment_config_mode.zig").DeploymentConfigMode;

/// The deployment configuration for a stack operation, including the deployment
/// mode.
pub const DeploymentConfig = struct {
    /// Specifies whether to disable rollback of the stack if the stack operation
    /// fails.
    ///
    /// Default: `false`
    disable_rollback: ?bool = null,

    /// Specifies the deployment mode for the stack operation. Possible values are:
    ///
    /// * `STANDARD` - Use the standard deployment behavior, ensuring resources are
    /// ready to serve traffic before completing the operation. This is the default.
    /// You do not need
    /// to specify this value explicitly.
    ///
    /// * `EXPRESS` - Complete the stack operation when resource configuration is
    /// applied, without waiting for resources to become ready to serve traffic.
    /// Resources continue
    /// becoming ready in the background.
    mode: ?DeploymentConfigMode = null,
};
