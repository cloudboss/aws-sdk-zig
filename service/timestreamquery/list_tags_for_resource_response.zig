const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A pagination token to resume pagination with a subsequent call to
    /// `ListTagsForResourceResponse`.
    next_token: ?[]const u8,

    /// The tags currently associated with the Timestream resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
