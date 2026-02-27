const Tag = @import("tag.zig").Tag;

pub const TagResourceResponse = struct {
    /// A list of tags as key-value pairs.
    tag_list: ?[]const Tag,

    pub const json_field_names = .{
        .tag_list = "TagList",
    };
};
