const JobRunState = @import("job_run_state.zig").JobRunState;

pub const ListJobRunsRequest = struct {
    /// The date and time after which the job runs were submitted.
    created_after: ?i64,

    /// The date and time before which the job runs were submitted.
    created_before: ?i64,

    /// The maximum number of job runs that can be listed.
    max_results: ?i32,

    /// The name of the job run.
    name: ?[]const u8,

    /// The token for the next set of job runs to return.
    next_token: ?[]const u8,

    /// The states of the job run.
    states: ?[]const JobRunState,

    /// The ID of the virtual cluster for which to list the job run.
    virtual_cluster_id: []const u8,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .states = "states",
        .virtual_cluster_id = "virtualClusterId",
    };
};
