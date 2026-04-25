const BatchUpdateTaskErrorCode = @import("batch_update_task_error_code.zig").BatchUpdateTaskErrorCode;

/// The error details for a task that could not be updated in a batch update
/// operation.
pub const BatchUpdateTaskError = struct {
    /// The error code.
    code: BatchUpdateTaskErrorCode,

    /// The farm ID of the task that could not be updated.
    farm_id: []const u8,

    /// The job ID of the task that could not be updated.
    job_id: []const u8,

    /// The error message.
    message: []const u8,

    /// The queue ID of the task that could not be updated.
    queue_id: []const u8,

    /// The step ID of the task that could not be updated.
    step_id: []const u8,

    /// The task ID of the task that could not be updated.
    task_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .farm_id = "farmId",
        .job_id = "jobId",
        .message = "message",
        .queue_id = "queueId",
        .step_id = "stepId",
        .task_id = "taskId",
    };
};
