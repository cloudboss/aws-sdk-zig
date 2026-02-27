const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The resource's tags.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
