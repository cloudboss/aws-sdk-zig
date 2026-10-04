/// A pairing of a session with the specific trace IDs to evaluate within that
/// session. Use this to evaluate individual traces rather than an entire
/// session.
pub const SessionTraceIds = struct {
    /// The unique identifier of the session that contains the traces to evaluate.
    session_id: []const u8,

    /// The list of trace IDs within the session to evaluate.
    trace_ids: []const []const u8,

    pub const json_field_names = .{
        .session_id = "sessionId",
        .trace_ids = "traceIds",
    };
};
