/// State of a workspace.
pub const WorkspaceStatusCode = enum {
    /// Workspace is being created. Deletion is disallowed until status is ACTIVE.
    creating,
    /// Workspace has been created and is usable.
    active,
    /// Workspace is being updated. Updates are allowed only when status is ACTIVE.
    updating,
    /// Workspace is being deleted. Deletions are allowed only when status is
    /// ACTIVE.
    deleting,
    /// Workspace creation failed. Refer to WorkspaceStatus.failureReason for more
    /// details.
    creation_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .creation_failed = "CREATION_FAILED",
    };
};
