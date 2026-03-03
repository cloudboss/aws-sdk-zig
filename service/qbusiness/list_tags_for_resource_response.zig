const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A list of tags associated with the Amazon Q Business application or data
    /// source.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
