const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags that are assigned to the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
