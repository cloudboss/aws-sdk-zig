const JobRun = @import("job_run.zig").JobRun;

pub const ListJobRunsResponse = struct {
    /// A list of job runs that have occurred for the specified job.
    job_runs: []const JobRun,

    /// A token that you can use in a subsequent call to retrieve the next set of
    /// results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .job_runs = "JobRuns",
        .next_token = "NextToken",
    };
};
