pub const ListJobRunsRequest = struct {
    /// The maximum number of results to return in this request.
    max_results: ?i32,

    /// The name of the job.
    name: []const u8,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .name = "Name",
        .next_token = "NextToken",
    };
};
