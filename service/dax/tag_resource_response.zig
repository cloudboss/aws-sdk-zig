const Tag = @import("tag.zig").Tag;

pub const TagResourceResponse = struct {
    /// The list of tags that are associated with the DAX resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
