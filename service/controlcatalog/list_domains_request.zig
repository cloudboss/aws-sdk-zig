pub const ListDomainsRequest = struct {
    /// The maximum number of results on a page or for an API request call.
    max_results: ?i32,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
