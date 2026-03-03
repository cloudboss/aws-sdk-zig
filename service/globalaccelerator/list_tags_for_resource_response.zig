const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Root level tag for the Tags parameters.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
