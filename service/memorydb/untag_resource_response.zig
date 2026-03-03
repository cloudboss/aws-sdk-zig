const Tag = @import("tag.zig").Tag;

pub const UntagResourceResponse = struct {
    /// The list of tags removed.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .tag_list = "TagList",
    };
};
