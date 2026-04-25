const BatchGetJobErrorCode = @import("batch_get_job_error_code.zig").BatchGetJobErrorCode;

/// The error details for a job that could not be retrieved in a batch get
/// operation.
pub const BatchGetJobError = struct {
    /// The error code.
    code: BatchGetJobErrorCode,

    /// The farm ID of the job that could not be retrieved.
    farm_id: []const u8,

    /// The job ID of the job that could not be retrieved.
    job_id: []const u8,

    /// The error message.
    message: []const u8,

    /// The queue ID of the job that could not be retrieved.
    queue_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .farm_id = "farmId",
        .job_id = "jobId",
        .message = "message",
        .queue_id = "queueId",
    };
};
