const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A list of tags attached to the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
