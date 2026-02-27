const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Returns a list of tags associated with a data store.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
