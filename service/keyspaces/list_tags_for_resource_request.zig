pub const ListTagsForResourceRequest = struct {
    /// The total number of tags to return in the output. If the total number of
    /// tags available is more than the value specified, a `NextToken` is provided
    /// in the output. To resume pagination, provide the `NextToken` value as an
    /// argument of a subsequent API invocation.
    max_results: ?i32 = null,

    /// The pagination token. To resume pagination, provide the `NextToken` value as
    /// argument of a subsequent API invocation.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Keyspaces resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_arn = "resourceArn",
    };
};
