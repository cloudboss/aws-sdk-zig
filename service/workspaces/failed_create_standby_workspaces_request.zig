const StandbyWorkspace = @import("standby_workspace.zig").StandbyWorkspace;

/// Describes the standby WorkSpace that could not be created.
pub const FailedCreateStandbyWorkspacesRequest = struct {
    /// The error code that is returned if the standby WorkSpace could not be
    /// created.
    error_code: ?[]const u8,

    /// The text of the error message that is returned if the standby WorkSpace
    /// could not be created.
    error_message: ?[]const u8,

    /// Information about the standby WorkSpace that could not be created.
    standby_workspace_request: ?StandbyWorkspace,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .standby_workspace_request = "StandbyWorkspaceRequest",
    };
};
