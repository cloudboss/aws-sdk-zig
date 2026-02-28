pub const ListStepsRequest = struct {
    /// The farm ID to include on the list of steps.
    farm_id: []const u8,

    /// The job ID to include on the list of steps.
    job_id: []const u8,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    max_results: ?i32 = null,

    /// The token for the next set of results, or `null` to start from the
    /// beginning.
    next_token: ?[]const u8,

    /// The queue ID to include on the list of steps.
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .queue_id = "queueId",
    };
};
