pub const DeleteApplicationRequest = struct {
    /// ID of the Application to delete
    id: []const u8,

    /// Name of the workspace to associate with the underlying Application
    workspace_name: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .workspace_name = "workspaceName",
    };
};
