const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
