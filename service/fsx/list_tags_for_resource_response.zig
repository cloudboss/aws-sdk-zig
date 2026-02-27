const Tag = @import("tag.zig").Tag;

/// The response object for `ListTagsForResource` operation.
pub const ListTagsForResourceResponse = struct {
    /// This is present if there are more tags than returned in the response
    /// (String). You
    /// can use the `NextToken` value in the later request to fetch the tags.
    next_token: ?[]const u8,

    /// A list of tags on the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
