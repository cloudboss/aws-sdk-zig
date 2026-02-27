const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// An array of objects, one for each tag (key and value) that’s associated with
    /// the Amazon Security Lake resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
