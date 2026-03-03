const EnvironmentLifecycleStatus = @import("environment_lifecycle_status.zig").EnvironmentLifecycleStatus;

/// Information about the current creation or deletion lifecycle state of an
/// Cloud9 development
/// environment.
pub const EnvironmentLifecycle = struct {
    /// If the environment failed to delete, the Amazon Resource Name (ARN) of the
    /// related Amazon Web Services
    /// resource.
    failure_resource: ?[]const u8 = null,

    /// Any informational message about the lifecycle state of the environment.
    reason: ?[]const u8 = null,

    /// The current creation or deletion lifecycle state of the environment.
    ///
    /// * `CREATING`: The environment is in the process of being created.
    ///
    /// * `CREATED`: The environment was successfully created.
    ///
    /// * `CREATE_FAILED`: The environment failed to be created.
    ///
    /// * `DELETING`: The environment is in the process of being deleted.
    ///
    /// * `DELETE_FAILED`: The environment failed to delete.
    status: ?EnvironmentLifecycleStatus = null,

    pub const json_field_names = .{
        .failure_resource = "failureResource",
        .reason = "reason",
        .status = "status",
    };
};
