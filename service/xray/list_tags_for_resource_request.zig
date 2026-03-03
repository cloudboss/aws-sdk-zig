pub const ListTagsForResourceRequest = struct {
    /// A pagination token. If multiple pages of results are returned, use the
    /// `NextToken` value returned with
    /// the current page of results as the value of this parameter to get the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of an X-Ray group or sampling rule.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_arn = "ResourceARN",
    };
};
