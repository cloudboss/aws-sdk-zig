const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Root level tag for the Tags parameters.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
