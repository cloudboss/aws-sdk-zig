const EvaluationJobStatus = @import("evaluation_job_status.zig").EvaluationJobStatus;

/// An evaluation job for deletion, and it’s current status.
pub const BatchDeleteEvaluationJobItem = struct {
    /// The Amazon Resource Name (ARN) of the evaluation job for deletion.
    job_identifier: []const u8,

    /// The status of the evaluation job for deletion.
    job_status: EvaluationJobStatus,

    pub const json_field_names = .{
        .job_identifier = "jobIdentifier",
        .job_status = "jobStatus",
    };
};
