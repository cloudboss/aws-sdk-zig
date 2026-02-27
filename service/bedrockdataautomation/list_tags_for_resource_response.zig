const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
