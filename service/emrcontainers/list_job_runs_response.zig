const JobRun = @import("job_run.zig").JobRun;

pub const ListJobRunsResponse = struct {
    /// This output lists information about the specified job runs.
    job_runs: ?[]const JobRun = null,

    /// This output displays the token for the next set of job runs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_runs = "jobRuns",
        .next_token = "nextToken",
    };
};
