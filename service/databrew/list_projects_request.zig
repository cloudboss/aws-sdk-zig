pub const ListProjectsRequest = struct {
    /// The maximum number of results to return in this request.
    max_results: ?i32 = null,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
