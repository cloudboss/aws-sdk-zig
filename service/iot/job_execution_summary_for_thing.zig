const JobExecutionSummary = @import("job_execution_summary.zig").JobExecutionSummary;

/// The job execution summary for a thing.
pub const JobExecutionSummaryForThing = struct {
    /// Contains a subset of information about a job execution.
    job_execution_summary: ?JobExecutionSummary,

    /// The unique identifier you assigned to this job when it was created.
    job_id: ?[]const u8,

    pub const json_field_names = .{
        .job_execution_summary = "jobExecutionSummary",
        .job_id = "jobId",
    };
};
