const JobRun = @import("job_run.zig").JobRun;

pub const GetJobRunResponse = struct {
    /// The output displays information about the job run.
    job_run: JobRun,

    pub const json_field_names = .{
        .job_run = "jobRun",
    };
};
