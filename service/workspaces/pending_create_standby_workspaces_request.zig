const WorkspaceState = @import("workspace_state.zig").WorkspaceState;

/// Information about the standby WorkSpace.
pub const PendingCreateStandbyWorkspacesRequest = struct {
    /// The identifier of the directory for the standby WorkSpace.
    directory_id: ?[]const u8,

    /// The operational state of the standby WorkSpace.
    state: ?WorkspaceState,

    /// Describes the standby WorkSpace that was created.
    ///
    /// Because this operation is asynchronous, the identifier returned is not
    /// immediately
    /// available for use with other operations. For example, if you call
    /// [
    /// DescribeWorkspaces](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeWorkspaces.html)
    /// before the WorkSpace is created, the information returned can be incomplete.
    user_name: ?[]const u8,

    /// The identifier of the standby WorkSpace.
    workspace_id: ?[]const u8,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .state = "State",
        .user_name = "UserName",
        .workspace_id = "WorkspaceId",
    };
};
