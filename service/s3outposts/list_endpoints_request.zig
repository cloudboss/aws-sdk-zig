pub const ListEndpointsRequest = struct {
    /// The maximum number of endpoints that will be returned in the response.
    max_results: ?i32 = null,

    /// If a previous response from this operation included a `NextToken` value,
    /// provide that value here to retrieve the next page of results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
