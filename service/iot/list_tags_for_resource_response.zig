const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The token to use to get the next set of results, or **null** if there are no
    /// additional results.
    next_token: ?[]const u8,

    /// The list of tags assigned to the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tags = "tags",
    };
};
