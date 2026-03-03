const Tag = @import("tag.zig").Tag;

/// Returns the list of tags for the specified WorkSpace Instance.
pub const ListTagsForResourceResponse = struct {
    /// Collection of tags associated with the WorkSpace Instance.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
