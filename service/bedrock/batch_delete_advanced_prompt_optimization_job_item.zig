const AdvancedPromptOptimizationJobStatus = @import("advanced_prompt_optimization_job_status.zig").AdvancedPromptOptimizationJobStatus;

/// Contains information about a successfully deleted advanced prompt
/// optimization job.
pub const BatchDeleteAdvancedPromptOptimizationJobItem = struct {
    /// The identifier of the deleted job.
    job_identifier: []const u8,

    /// The status of the deleted job.
    job_status: AdvancedPromptOptimizationJobStatus,

    pub const json_field_names = .{
        .job_identifier = "jobIdentifier",
        .job_status = "jobStatus",
    };
};
