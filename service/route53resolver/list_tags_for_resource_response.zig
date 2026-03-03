const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// If more than `MaxResults` tags match the specified criteria, you can submit
    /// another
    /// `ListTagsForResource` request to get the next group of results. In the next
    /// request, specify the value of
    /// `NextToken` from the previous response.
    next_token: ?[]const u8 = null,

    /// The tags that are associated with the resource that you specified in the
    /// `ListTagsForResource` request.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
