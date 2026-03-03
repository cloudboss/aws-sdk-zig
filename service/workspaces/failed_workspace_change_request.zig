/// Describes a WorkSpace that could not be rebooted. (RebootWorkspaces),
/// rebuilt (RebuildWorkspaces), restored (RestoreWorkspace), terminated
/// (TerminateWorkspaces), started (StartWorkspaces), or stopped
/// (StopWorkspaces).
pub const FailedWorkspaceChangeRequest = struct {
    /// The error code that is returned if the WorkSpace cannot be rebooted.
    error_code: ?[]const u8 = null,

    /// The text of the error message that is returned if the WorkSpace cannot be
    /// rebooted.
    error_message: ?[]const u8 = null,

    /// The identifier of the WorkSpace.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .workspace_id = "WorkspaceId",
    };
};
