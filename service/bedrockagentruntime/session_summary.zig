const SessionStatus = @import("session_status.zig").SessionStatus;

/// Contains details about a session. For more information about sessions, see
/// [Store and retrieve conversation history and context with Amazon Bedrock
/// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
pub const SessionSummary = struct {
    /// The timestamp for when the session was created.
    created_at: i64,

    /// The timestamp for when the session was last modified.
    last_updated_at: i64,

    /// The Amazon Resource Name (ARN) of the session.
    session_arn: []const u8,

    /// The unique identifier for the session.
    session_id: []const u8,

    /// The current status of the session.
    session_status: SessionStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .session_arn = "sessionArn",
        .session_id = "sessionId",
        .session_status = "sessionStatus",
    };
};
