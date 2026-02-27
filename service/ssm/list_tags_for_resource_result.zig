const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResult = struct {
    /// A list of tags.
    tag_list: ?[]const Tag,

    pub const json_field_names = .{
        .tag_list = "TagList",
    };
};
