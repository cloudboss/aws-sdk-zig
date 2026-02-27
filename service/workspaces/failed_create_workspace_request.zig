const WorkspaceRequest = @import("workspace_request.zig").WorkspaceRequest;

/// Describes a WorkSpace that cannot be created.
pub const FailedCreateWorkspaceRequest = struct {
    /// The error code that is returned if the WorkSpace cannot be created.
    error_code: ?[]const u8,

    /// The text of the error message that is returned if the WorkSpace cannot be
    /// created.
    error_message: ?[]const u8,

    /// Information about the WorkSpace.
    workspace_request: ?WorkspaceRequest,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .workspace_request = "WorkspaceRequest",
    };
};
