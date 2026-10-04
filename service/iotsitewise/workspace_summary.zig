const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;

/// Contains summary information about a workspace, including its name, ARN,
/// status, and
/// creation and update timestamps.
pub const WorkspaceSummary = struct {
    /// The ARN of the workspace.
    arn: []const u8,

    /// The date the workspace was created, in Unix epoch time.
    created_at: i64,

    /// The name of the workspace.
    name: []const u8,

    /// The status of the workspace.
    status: WorkspaceStatus,

    /// The date the workspace was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
