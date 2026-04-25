const BatchGetSessionErrorCode = @import("batch_get_session_error_code.zig").BatchGetSessionErrorCode;

/// The error details for a session that could not be retrieved in a batch get
/// operation.
pub const BatchGetSessionError = struct {
    /// The error code.
    code: BatchGetSessionErrorCode,

    /// The farm ID of the session that could not be retrieved.
    farm_id: []const u8,

    /// The job ID of the session that could not be retrieved.
    job_id: []const u8,

    /// The error message.
    message: []const u8,

    /// The queue ID of the session that could not be retrieved.
    queue_id: []const u8,

    /// The session ID of the session that could not be retrieved.
    session_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .farm_id = "farmId",
        .job_id = "jobId",
        .message = "message",
        .queue_id = "queueId",
        .session_id = "sessionId",
    };
};
