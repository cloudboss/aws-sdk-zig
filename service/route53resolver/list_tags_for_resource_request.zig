pub const ListTagsForResourceRequest = struct {
    /// The maximum number of tags that you want to return in the response to a
    /// `ListTagsForResource` request.
    /// If you don't specify a value for `MaxResults`, Resolver returns up to 100
    /// tags.
    max_results: ?i32,

    /// For the first `ListTagsForResource` request, omit this value.
    ///
    /// If you have more than `MaxResults` tags, you can submit another
    /// `ListTagsForResource` request
    /// to get the next group of tags for the resource. In the next request, specify
    /// the value of `NextToken` from the previous response.
    next_token: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the resource that you want to list tags
    /// for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_arn = "ResourceArn",
    };
};
