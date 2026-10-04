const AdvancedPromptOptimizationJobStatus = @import("advanced_prompt_optimization_job_status.zig").AdvancedPromptOptimizationJobStatus;

/// Contains a summary of an advanced prompt optimization job.
pub const AdvancedPromptOptimizationJobSummary = struct {
    /// The time at which the job was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: []const u8,

    /// The name of the job.
    job_name: []const u8,

    /// The status of the job.
    job_status: AdvancedPromptOptimizationJobStatus,

    /// The time at which the job was last modified.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .job_status = "jobStatus",
        .last_modified_time = "lastModifiedTime",
    };
};
