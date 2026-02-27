/// The specification of which trace or span IDs to evaluate within the provided
/// input data. Allows precise targeting of evaluation at different levels: tool
/// calls, traces, or sessions.
pub const EvaluationTarget = union(enum) {
    /// The list of specific span IDs to evaluate within the provided traces. Used
    /// to target evaluation at individual tool calls or specific operations within
    /// the agent's execution flow.
    span_ids: ?[]const []const u8,
    /// The list of trace IDs to evaluate, representing complete request-response
    /// interactions. Used to evaluate entire conversation turns or specific agent
    /// interactions within a session.
    trace_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .span_ids = "spanIds",
        .trace_ids = "traceIds",
    };
};
