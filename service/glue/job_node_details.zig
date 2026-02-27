const JobRun = @import("job_run.zig").JobRun;

/// The details of a Job node present in the workflow.
pub const JobNodeDetails = struct {
    /// The information for the job runs represented by the job node.
    job_runs: ?[]const JobRun,

    pub const json_field_names = .{
        .job_runs = "JobRuns",
    };
};
