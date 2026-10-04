pub const ListSpacesRequest = struct {
    /// The ID of the Amazon Web Services account that contains the spaces.
    aws_account_id: []const u8,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
