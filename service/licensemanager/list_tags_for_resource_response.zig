const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Information about the tags.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
