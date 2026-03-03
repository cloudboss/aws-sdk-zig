pub const ListTagsForResourceRequest = struct {
    /// The maximum number of tags to return.
    max_results: ?i32 = null,

    /// The token that specifies the next page of results to return.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource whose tags are to be
    /// returned.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_arn = "resourceArn",
    };
};
