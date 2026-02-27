const WorkspaceStatusCode = @import("workspace_status_code.zig").WorkspaceStatusCode;

/// The status of the workspace.
pub const WorkspaceStatus = struct {
    /// The current status of the workspace.
    status_code: WorkspaceStatusCode,

    pub const json_field_names = .{
        .status_code = "statusCode",
    };
};
