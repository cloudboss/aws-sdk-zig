pub const WorkspaceStatus = enum {
    /// Workspace is active.
    active,
    /// Workspace is being created.
    creating,
    /// Workspace is being deleted.
    deleting,
    /// Workspace is in an invalid state, it can only and should be deleted.
    failed,
    /// Workspace is being updated.
    updating,
    /// Workspace is being upgraded to enterprise.
    upgrading,
    /// Workspace deletion failed.
    deletion_failed,
    /// Workspace creation failed.
    creation_failed,
    /// Workspace update failed.
    update_failed,
    /// Workspace upgrade failed.
    upgrade_failed,
    /// Failed to remove enterprise license from workspace.
    license_removal_failed,
    /// Workspace version is being updated.
    version_updating,
    /// Workspace version update failed.
    version_update_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
        .upgrading = "UPGRADING",
        .deletion_failed = "DELETION_FAILED",
        .creation_failed = "CREATION_FAILED",
        .update_failed = "UPDATE_FAILED",
        .upgrade_failed = "UPGRADE_FAILED",
        .license_removal_failed = "LICENSE_REMOVAL_FAILED",
        .version_updating = "VERSION_UPDATING",
        .version_update_failed = "VERSION_UPDATE_FAILED",
    };
};
