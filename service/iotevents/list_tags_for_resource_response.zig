const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The list of tags assigned to the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
