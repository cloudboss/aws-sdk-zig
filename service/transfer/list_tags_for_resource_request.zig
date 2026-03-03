pub const ListTagsForResourceRequest = struct {
    /// Requests the tags associated with a particular Amazon Resource Name (ARN).
    /// An ARN is an identifier for a specific Amazon Web Services resource, such as
    /// a server, user, or role.
    arn: []const u8,

    /// Specifies the number of tags to return as a response to the
    /// `ListTagsForResource` request.
    max_results: ?i32 = null,

    /// When you request additional results from the `ListTagsForResource`
    /// operation, a `NextToken` parameter is returned in the input. You can then
    /// pass in a subsequent command to the `NextToken` parameter to continue
    /// listing additional tags.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
