pub const ListTagsForResourceRequest = struct {
    /// The maximum number of results to return at one time. The default is 25.
    ///
    /// Valid Range: Minimum value of 1. Maximum value of 250.
    max_results: ?i32,

    /// The string that specifies the next page of results.
    next_token: ?[]const u8,

    /// The ARN of the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_arn = "resourceARN",
    };
};
