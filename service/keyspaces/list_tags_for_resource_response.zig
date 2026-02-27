const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A token to specify where to start paginating. This is the `NextToken` from a
    /// previously truncated response.
    next_token: ?[]const u8,

    /// A list of tags.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tags = "tags",
    };
};
