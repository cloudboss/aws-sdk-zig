const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Key-value pairs associated with the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
