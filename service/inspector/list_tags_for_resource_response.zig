const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A collection of key and value pairs.
    tags: []const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
