const InvocationStepPayload = @import("invocation_step_payload.zig").InvocationStepPayload;

/// Stores fine-grained state checkpoints, including text and images, for each
/// interaction in an invocation in a session. For more information about
/// sessions, see [Store and retrieve conversation history and context with
/// Amazon Bedrock
/// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
pub const InvocationStep = struct {
    /// The unique identifier (in UUID format) for the invocation that includes the
    /// invocation step.
    invocation_id: []const u8,

    /// The unique identifier (in UUID format) for the invocation step.
    invocation_step_id: []const u8,

    /// The timestamp for when the invocation step was created.
    invocation_step_time: i64,

    /// Payload content, such as text and images, for the invocation step.
    payload: InvocationStepPayload,

    /// The unique identifier of the session containing the invocation step.
    session_id: []const u8,

    pub const json_field_names = .{
        .invocation_id = "invocationId",
        .invocation_step_id = "invocationStepId",
        .invocation_step_time = "invocationStepTime",
        .payload = "payload",
        .session_id = "sessionId",
    };
};
