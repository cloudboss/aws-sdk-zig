/// The contextual information that uniquely identifies a span within the
/// distributed tracing system. Contains session, trace, and span identifiers
/// used to correlate evaluation results with specific agent execution points.
pub const SpanContext = struct {
    /// The unique identifier of the session containing this span. Sessions
    /// represent complete conversation flows and are detected using configurable
    /// `SessionTimeoutMinutes` (default 15 minutes).
    session_id: []const u8,

    /// The unique identifier of the specific span being referenced. Spans represent
    /// individual operations like tool calls, model invocations, or other discrete
    /// actions within the agent's execution.
    span_id: ?[]const u8 = null,

    /// The unique identifier of the trace containing this span. Traces represent
    /// individual request-response interactions within a session and group related
    /// spans together.
    trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .session_id = "sessionId",
        .span_id = "spanId",
        .trace_id = "traceId",
    };
};
