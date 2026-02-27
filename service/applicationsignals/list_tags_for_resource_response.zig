const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The list of tag keys and values associated with the resource you specified.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
