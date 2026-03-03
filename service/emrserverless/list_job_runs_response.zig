const JobRunSummary = @import("job_run_summary.zig").JobRunSummary;

pub const ListJobRunsResponse = struct {
    /// The output lists information about the specified job runs.
    job_runs: []const JobRunSummary,

    /// The output displays the token for the next set of job run results. This is
    /// required for pagination and is available as a response of the previous
    /// request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_runs = "jobRuns",
        .next_token = "nextToken",
    };
};
