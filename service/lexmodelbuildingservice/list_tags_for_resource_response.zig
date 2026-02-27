const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags associated with a resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
