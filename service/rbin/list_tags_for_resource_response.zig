const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Information about the tags assigned to the retention rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
