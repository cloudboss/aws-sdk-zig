const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The metadata assigned to an Amazon RDS resource consisting of a key-value
    /// pair.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
