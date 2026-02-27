const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags assigned to the report definition resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
