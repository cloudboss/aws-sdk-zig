const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Returns the key-value pairs assigned to ARNs that you can use to group and
    /// search for resources by type. You can attach this metadata to resources
    /// (capabilities, partnerships, and so on) for any purpose.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
