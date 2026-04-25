const BatchGetTaskErrorCode = @import("batch_get_task_error_code.zig").BatchGetTaskErrorCode;

/// The error details for a task that could not be retrieved in a batch get
/// operation.
pub const BatchGetTaskError = struct {
    /// The error code.
    code: BatchGetTaskErrorCode,

    /// The farm ID of the task that could not be retrieved.
    farm_id: []const u8,

    /// The job ID of the task that could not be retrieved.
    job_id: []const u8,

    /// The error message.
    message: []const u8,

    /// The queue ID of the task that could not be retrieved.
    queue_id: []const u8,

    /// The step ID of the task that could not be retrieved.
    step_id: []const u8,

    /// The task ID of the task that could not be retrieved.
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
