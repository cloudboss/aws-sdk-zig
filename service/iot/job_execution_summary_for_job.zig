const JobExecutionSummary = @import("job_execution_summary.zig").JobExecutionSummary;

/// Contains a summary of information about job executions for a specific
/// job.
pub const JobExecutionSummaryForJob = struct {
    /// Contains a subset of information about a job execution.
    job_execution_summary: ?JobExecutionSummary,

    /// The ARN of the thing on which the job execution is running.
    thing_arn: ?[]const u8,

    pub const json_field_names = .{
        .job_execution_summary = "jobExecutionSummary",
        .thing_arn = "thingArn",
    };
};
