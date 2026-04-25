const BatchGetSessionActionErrorCode = @import("batch_get_session_action_error_code.zig").BatchGetSessionActionErrorCode;

/// The error details for a session action that could not be retrieved in a
/// batch get operation.
pub const BatchGetSessionActionError = struct {
    /// The error code.
    code: BatchGetSessionActionErrorCode,

    /// The farm ID of the session action that could not be retrieved.
    farm_id: []const u8,

    /// The job ID of the session action that could not be retrieved.
    job_id: []const u8,

    /// The error message.
    message: []const u8,

    /// The queue ID of the session action that could not be retrieved.
    queue_id: []const u8,

    /// The session action ID of the session action that could not be retrieved.
    session_action_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .farm_id = "farmId",
        .job_id = "jobId",
        .message = "message",
        .queue_id = "queueId",
        .session_action_id = "sessionActionId",
    };
};
