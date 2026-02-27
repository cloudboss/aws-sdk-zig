pub const ListTagsForResourceRequest = struct {
    /// The maximum number of objects that are returned for the request.
    max_results: ?i32,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8,

    /// The unique identifier for the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_arn = "ResourceArn",
    };
};
