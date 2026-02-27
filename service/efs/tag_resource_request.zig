const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ID specifying the EFS resource that you want to create a tag for.
    resource_id: []const u8,

    /// An array of `Tag` objects to add. Each `Tag` object is a key-value
    /// pair.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .tags = "Tags",
    };
};
