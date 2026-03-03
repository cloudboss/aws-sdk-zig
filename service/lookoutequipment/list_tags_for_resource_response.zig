const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Any tags associated with the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
