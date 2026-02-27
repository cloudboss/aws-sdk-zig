/// Specifies the WorkSpace Instance to retrieve tags for.
pub const ListTagsForResourceRequest = struct {
    /// Unique identifier of the WorkSpace Instance.
    workspace_instance_id: []const u8,

    pub const json_field_names = .{
        .workspace_instance_id = "WorkspaceInstanceId",
    };
};
