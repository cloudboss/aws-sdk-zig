const JobRunMode = @import("job_run_mode.zig").JobRunMode;
const JobRunState = @import("job_run_state.zig").JobRunState;

pub const ListJobRunsRequest = struct {
    /// The ID of the application for which to list the job run.
    application_id: []const u8,

    /// The lower bound of the option to filter by creation date and time.
    created_at_after: ?i64,

    /// The upper bound of the option to filter by creation date and time.
    created_at_before: ?i64,

    /// The maximum number of job runs that can be listed.
    max_results: ?i32,

    /// The mode of the job runs to list.
    mode: ?JobRunMode,

    /// The token for the next set of job run results.
    next_token: ?[]const u8,

    /// An optional filter for job run states. Note that if this filter contains
    /// multiple states, the resulting list will be grouped by the state.
    states: ?[]const JobRunState,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .created_at_after = "createdAtAfter",
        .created_at_before = "createdAtBefore",
        .max_results = "maxResults",
        .mode = "mode",
        .next_token = "nextToken",
        .states = "states",
    };
};
