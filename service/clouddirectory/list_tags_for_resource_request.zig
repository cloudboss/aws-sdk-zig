pub const ListTagsForResourceRequest = struct {
    /// The `MaxResults` parameter sets the maximum number of results returned in a
    /// single page. This is for future use and is not supported currently.
    max_results: ?i32 = null,

    /// The pagination token. This is for future use. Currently pagination is not
    /// supported for
    /// tagging.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource. Tagging is only supported
    /// for
    /// directories.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_arn = "ResourceArn",
    };
};
