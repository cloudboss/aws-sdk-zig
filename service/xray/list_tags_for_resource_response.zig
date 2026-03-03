const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A pagination token. If multiple pages of results are returned, use the
    /// `NextToken` value returned with
    /// the current page of results to get the next page of results.
    next_token: ?[]const u8 = null,

    /// A list of tags, as key and value pairs, that is associated with the
    /// specified X-Ray group or sampling rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
