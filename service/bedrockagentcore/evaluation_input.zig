/// The input data structure containing agent session spans in OpenTelemetry
/// format. Supports traces from frameworks like Strands (AgentCore Runtime) and
/// LangGraph with OpenInference instrumentation for comprehensive evaluation.
pub const EvaluationInput = union(enum) {
    /// The collection of spans representing agent execution traces within a
    /// session. Each span contains detailed information about tool calls, model
    /// interactions, and other agent activities that can be evaluated for quality
    /// and performance.
    session_spans: ?[]const []const u8,

    pub const json_field_names = .{
        .session_spans = "sessionSpans",
    };
};
