const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The token that specifies the next page of results to return.
    next_token: ?[]const u8 = null,

    /// List of tags returned by the `ListTagsForResource` operation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tags = "tags",
    };
};
