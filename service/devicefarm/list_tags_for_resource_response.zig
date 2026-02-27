const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags to add to the resource. A tag is an array of key-value pairs. Tag
    /// keys can have a maximum
    /// character length of 128 characters. Tag values can have a maximum length of
    /// 256 characters.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
