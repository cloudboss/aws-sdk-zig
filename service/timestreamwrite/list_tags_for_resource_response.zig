const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags currently associated with the Timestream resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
