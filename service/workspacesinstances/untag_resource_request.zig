/// Specifies tags to remove from a WorkSpace Instance.
pub const UntagResourceRequest = struct {
    /// Keys of tags to be removed.
    tag_keys: []const []const u8,

    /// Unique identifier of the WorkSpace Instance to untag.
    workspace_instance_id: []const u8,

    pub const json_field_names = .{
        .tag_keys = "TagKeys",
        .workspace_instance_id = "WorkspaceInstanceId",
    };
};
