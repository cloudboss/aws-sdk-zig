const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// `NextToken` is present if the response payload is paginated. You can use
    /// `NextToken` in a subsequent request to fetch the next page of access point
    /// descriptions.
    next_token: ?[]const u8 = null,

    /// An array of the tags for the specified EFS resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
