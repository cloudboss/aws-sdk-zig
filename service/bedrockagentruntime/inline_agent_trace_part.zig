const Caller = @import("caller.zig").Caller;
const Trace = @import("trace.zig").Trace;

/// Contains information about the agent and session, alongside the agent's
/// reasoning process and results from calling API actions and querying
/// knowledge bases and metadata about the trace. You can use the trace to
/// understand how the agent arrived at the response it provided the customer.
/// For more information, see [Trace
/// enablement](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-test.html#trace-enablement).
pub const InlineAgentTracePart = struct {
    /// The caller chain for the trace part.
    caller_chain: ?[]const Caller,

    /// The collaborator name for the trace part.
    collaborator_name: ?[]const u8,

    /// The time that trace occurred.
    event_time: ?i64,

    /// The unique identifier of the session with the agent.
    session_id: ?[]const u8,

    /// Contains one part of the agent's reasoning process and results from calling
    /// API actions and querying knowledge bases. You can use the trace to
    /// understand how the agent arrived at the response it provided the customer.
    /// For more information, see [Trace
    /// enablement](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-test.html#trace-enablement).
    trace: ?Trace,

    pub const json_field_names = .{
        .caller_chain = "callerChain",
        .collaborator_name = "collaboratorName",
        .event_time = "eventTime",
        .session_id = "sessionId",
        .trace = "trace",
    };
};
