const TagDescription = @import("tag_description.zig").TagDescription;

pub const DescribeTagsResult = struct {
    /// The token to include in another request to get the next page of items.
    /// This value is `null` when there are no more items to return.
    next_token: ?[]const u8,

    /// The tags.
    tags: ?[]const TagDescription,
};
