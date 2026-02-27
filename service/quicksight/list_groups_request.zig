pub const ListGroupsRequest = struct {
    /// The ID for the Amazon Web Services account that the group is in. Currently,
    /// you use the ID for the
    /// Amazon Web Services account that contains your Amazon Quick Sight account.
    aws_account_id: []const u8,

    /// The maximum number of results to return.
    max_results: ?i32,

    /// The namespace that you want a list of groups from.
    namespace: []const u8,

    /// A pagination token that can be used in a subsequent request.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .max_results = "MaxResults",
        .namespace = "Namespace",
        .next_token = "NextToken",
    };
};
