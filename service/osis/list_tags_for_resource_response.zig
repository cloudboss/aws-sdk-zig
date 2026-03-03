const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A list of tags associated with the given pipeline.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
