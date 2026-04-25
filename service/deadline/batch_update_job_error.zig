const BatchUpdateJobErrorCode = @import("batch_update_job_error_code.zig").BatchUpdateJobErrorCode;

/// The error details for a job that could not be updated in a batch update
/// operation.
pub const BatchUpdateJobError = struct {
    /// The error code.
    code: BatchUpdateJobErrorCode,

    /// The farm ID of the job that could not be updated.
    farm_id: []const u8,

    /// The job ID of the job that could not be updated.
    job_id: []const u8,

    /// The error message.
    message: []const u8,

    /// The queue ID of the job that could not be updated.
    queue_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .farm_id = "farmId",
        .job_id = "jobId",
        .message = "message",
        .queue_id = "queueId",
    };
};
