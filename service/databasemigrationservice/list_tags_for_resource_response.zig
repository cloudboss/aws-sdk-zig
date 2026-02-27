const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A list of tags for the resource.
    tag_list: ?[]const Tag,

    pub const json_field_names = .{
        .tag_list = "TagList",
    };
};
