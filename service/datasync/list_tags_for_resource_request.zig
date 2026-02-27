/// ListTagsForResourceRequest
pub const ListTagsForResourceRequest = struct {
    /// Specifies how many results that you want in the response.
    max_results: ?i32,

    /// Specifies an opaque string that indicates the position to begin the next
    /// list of
    /// results in the response.
    next_token: ?[]const u8,

    /// Specifies the Amazon Resource Name (ARN) of the resource that you want tag
    /// information
    /// on.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_arn = "ResourceArn",
    };
};
