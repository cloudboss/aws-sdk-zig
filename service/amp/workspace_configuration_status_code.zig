pub const WorkspaceConfigurationStatusCode = enum {
    /// Workspace configuration has been updated. Update is disallowed until
    /// workspace configuration is ACTIVE and workspace status is ACTIVE.
    active,
    /// Workspace configuration is being updated. Update is disallowed until
    /// workspace configuration is ACTIVE and workspace status is ACTIVE.
    updating,
    /// Workspace configuration update failed.
    update_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
    };
};
