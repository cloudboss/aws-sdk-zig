const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The token that specifies the next page of results to return.
    next_token: ?[]const u8,

    /// List of tags returned by the `ListTagsForResource` operation.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tags = "tags",
    };
};
