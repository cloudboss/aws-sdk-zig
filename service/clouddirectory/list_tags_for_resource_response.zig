const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The token to use to retrieve the next page of results. This value is null
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// A list of tag key value pairs that are associated with the response.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
