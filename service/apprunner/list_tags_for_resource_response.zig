const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A list of the tag key-value pairs that are associated with the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
