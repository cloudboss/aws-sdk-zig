/// Contains details about an invocation in a session. For more information
/// about sessions, see [Store and retrieve conversation history and context
/// with Amazon Bedrock
/// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
pub const InvocationSummary = struct {
    /// The timestamp for when the invocation was created.
    created_at: i64,

    /// A unique identifier for the invocation in UUID format.
    invocation_id: []const u8,

    /// The unique identifier for the session associated with the invocation.
    session_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .invocation_id = "invocationId",
        .session_id = "sessionId",
    };
};
