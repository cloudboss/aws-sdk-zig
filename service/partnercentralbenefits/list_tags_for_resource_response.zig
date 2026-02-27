const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A list of key-value pairs representing the tags associated with the
    /// resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
