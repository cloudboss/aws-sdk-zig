/// Shared pagination fields for List operation inputs (nextToken + maxResults).
pub const ListSessionsRequest = struct {
    /// The farm ID for the list of sessions.
    farm_id: []const u8,

    /// The job ID for the list of sessions.
    job_id: []const u8,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    max_results: ?i32 = null,

    /// The token for the next set of results, or `null` to start from the
    /// beginning.
    next_token: ?[]const u8 = null,

    /// The queue ID for the list of sessions
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .queue_id = "queueId",
    };
};
