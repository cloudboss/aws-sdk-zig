/// The request object for `ListTagsForResource` operation.
pub const ListTagsForResourceRequest = struct {
    /// Maximum number of tags to return in the response (integer). This
    /// parameter value must be greater than 0. The number of items that Amazon FSx
    /// returns is
    /// the minimum of the `MaxResults` parameter specified in the request and the
    /// service's internal maximum number of items per page.
    max_results: ?i32,

    /// Opaque pagination token returned from a previous
    /// `ListTagsForResource` operation (String). If a token present, the action
    /// continues the list from where the returning call left off.
    next_token: ?[]const u8,

    /// The ARN of the Amazon FSx resource that will have its tags listed.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_arn = "ResourceARN",
    };
};
