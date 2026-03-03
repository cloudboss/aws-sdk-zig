pub const ListTagsForResourceRequest = struct {
    /// The maximum number of tags to return.
    max_results: ?i32 = null,

    /// A pagination token to resume pagination.
    next_token: ?[]const u8 = null,

    /// The Timestream resource with tags to be listed. This value is an Amazon
    /// Resource Name
    /// (ARN).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_arn = "ResourceARN",
    };
};
