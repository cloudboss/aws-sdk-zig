pub const ListDomainsRequest = struct {
    /// The maximum number of results that are returned per call. You can use
    /// `NextToken` to obtain more pages of results. The default is 100; the maximum
    /// allowed page size is also 100.
    max_results: ?i32 = null,

    /// If `NextToken` is returned, there are more results available. The value of
    /// `NextToken` is a unique pagination token for each page. Make the call
    /// again using the returned token to retrieve the next page. Keep all other
    /// arguments
    /// unchanged. Each pagination token expires after 24 hours.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
