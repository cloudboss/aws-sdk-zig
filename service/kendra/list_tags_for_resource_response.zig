const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A list of tags associated with the index, FAQ, data source, or other
    /// resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
