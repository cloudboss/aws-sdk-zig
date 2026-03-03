const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A map of the key-value pairs for the tag or tags assigned to the specified
    /// resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
