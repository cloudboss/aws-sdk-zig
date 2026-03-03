const TagEntry = @import("tag_entry.zig").TagEntry;

pub const ListTagsForResourceResponse = struct {
    /// Key-value pairs of metadata assigned to the resource.
    tags: ?[]const TagEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
