pub const ListDatabasesRequest = struct {
    /// The total number of items to return in the output. If the total number of
    /// items
    /// available is more than the value specified, a NextToken is provided in the
    /// output. To
    /// resume pagination, provide the NextToken value as argument of a subsequent
    /// API
    /// invocation.
    max_results: ?i32,

    /// The pagination token. To resume pagination, provide the NextToken value as
    /// argument of a
    /// subsequent API invocation.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
