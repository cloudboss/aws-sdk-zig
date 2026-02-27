const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags (metadata) that you have assigned to the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
