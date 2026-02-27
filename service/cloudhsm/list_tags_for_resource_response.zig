const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// One or more tags.
    tag_list: []const Tag,

    pub const json_field_names = .{
        .tag_list = "TagList",
    };
};
