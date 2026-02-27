const Tag = @import("tag.zig").Tag;

/// Specifies tags to add to a WorkSpace Instance.
pub const TagResourceRequest = struct {
    /// Tags to be added to the WorkSpace Instance.
    tags: []const Tag,

    /// Unique identifier of the WorkSpace Instance to tag.
    workspace_instance_id: []const u8,

    pub const json_field_names = .{
        .tags = "Tags",
        .workspace_instance_id = "WorkspaceInstanceId",
    };
};
