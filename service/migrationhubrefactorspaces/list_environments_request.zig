pub const ListEnvironmentsRequest = struct {
    /// The maximum number of results to return with a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned `nextToken` value.
    max_results: ?i32,

    /// The token for the next page of results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
