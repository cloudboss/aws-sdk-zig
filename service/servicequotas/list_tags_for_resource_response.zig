const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A complex data type that contains zero or more tag elements.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
