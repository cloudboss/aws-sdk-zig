const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// An array of the tags associated with this resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
