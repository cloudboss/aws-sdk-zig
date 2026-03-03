/// Placeholder documentation for ListNetworksRequest
pub const ListNetworksRequest = struct {
    /// The maximum number of items to return.
    max_results: ?i32 = null,

    /// The token to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
