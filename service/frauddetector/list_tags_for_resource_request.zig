pub const ListTagsForResourceRequest = struct {
    /// The maximum number of objects to return for the request.
    max_results: ?i32 = null,

    /// The next token from the previous results.
    next_token: ?[]const u8 = null,

    /// The ARN that specifies the resource whose tags you want to list.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_arn = "resourceARN",
    };
};
