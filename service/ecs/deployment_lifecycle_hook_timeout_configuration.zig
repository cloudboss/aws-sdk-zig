const DeploymentLifecycleHookAction = @import("deployment_lifecycle_hook_action.zig").DeploymentLifecycleHookAction;

/// The timeout configuration for a deployment lifecycle hook. This determines
/// how long Amazon ECS waits for the hook to complete before taking the
/// specified timeout action.
pub const DeploymentLifecycleHookTimeoutConfiguration = struct {
    /// The action Amazon ECS takes when the lifecycle hook times out. Valid values
    /// are:
    ///
    /// * `CONTINUE` - Proceeds the deployment to the next lifecycle stage.
    /// * `ROLLBACK` - Rolls back the deployment to the previous service revision.
    ///
    /// Default: `ROLLBACK`
    action: ?DeploymentLifecycleHookAction = null,

    /// The number of minutes Amazon ECS waits for the lifecycle hook to complete
    /// before taking the timeout action.
    ///
    /// Default: 1440 (24 hours)
    timeout_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .action = "action",
        .timeout_in_minutes = "timeoutInMinutes",
    };
};
