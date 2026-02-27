const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A map of the key-value pairs assigned to the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
