const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags associated with the resource.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .tag_list = "TagList",
    };
};
