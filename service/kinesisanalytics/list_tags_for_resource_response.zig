const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The key-value tags assigned to the application.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
