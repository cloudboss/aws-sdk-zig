const SpanContext = @import("span_context.zig").SpanContext;

/// The contextual information associated with an evaluation, including span
/// context details that identify the specific traces and sessions being
/// evaluated within the agent's execution flow.
pub const Context = union(enum) {
    /// The span context information that uniquely identifies the trace and span
    /// being evaluated, including session ID, trace ID, and span ID for precise
    /// targeting within the agent's execution flow.
    span_context: ?SpanContext,

    pub const json_field_names = .{
        .span_context = "spanContext",
    };
};
