const BatchGetStepErrorCode = @import("batch_get_step_error_code.zig").BatchGetStepErrorCode;

/// The error details for a step that could not be retrieved in a batch get
/// operation.
pub const BatchGetStepError = struct {
    /// The error code.
    code: BatchGetStepErrorCode,

    /// The farm ID of the step that could not be retrieved.
    farm_id: []const u8,

    /// The job ID of the step that could not be retrieved.
    job_id: []const u8,

    /// The error message.
    message: []const u8,

    /// The queue ID of the step that could not be retrieved.
    queue_id: []const u8,

    /// The step ID of the step that could not be retrieved.
    step_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .farm_id = "farmId",
        .job_id = "jobId",
        .message = "message",
        .queue_id = "queueId",
        .step_id = "stepId",
    };
};
