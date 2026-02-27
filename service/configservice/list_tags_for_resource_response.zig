const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8,

    /// The tags for the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
