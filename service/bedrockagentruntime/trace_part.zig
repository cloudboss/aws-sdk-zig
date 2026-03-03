const Caller = @import("caller.zig").Caller;
const Trace = @import("trace.zig").Trace;

/// Contains information about the agent and session, alongside the agent's
/// reasoning process and results from calling API actions and querying
/// knowledge bases and metadata about the trace. You can use the trace to
/// understand how the agent arrived at the response it provided the customer.
/// For more information, see [Trace
/// enablement](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-test.html#trace-enablement).
pub const TracePart = struct {
    /// The unique identifier of the alias of the agent.
    agent_alias_id: ?[]const u8 = null,

    /// The unique identifier of the agent.
    agent_id: ?[]const u8 = null,

    /// The version of the agent.
    agent_version: ?[]const u8 = null,

    /// The part's caller chain.
    caller_chain: ?[]const Caller = null,

    /// The part's collaborator name.
    collaborator_name: ?[]const u8 = null,

    /// The time of the trace.
    event_time: ?i64 = null,

    /// The unique identifier of the session with the agent.
    session_id: ?[]const u8 = null,

    /// Contains one part of the agent's reasoning process and results from calling
    /// API actions and querying knowledge bases. You can use the trace to
    /// understand how the agent arrived at the response it provided the customer.
    /// For more information, see [Trace
    /// enablement](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-test.html#trace-enablement).
    trace: ?Trace = null,

    pub const json_field_names = .{
        .agent_alias_id = "agentAliasId",
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .caller_chain = "callerChain",
        .collaborator_name = "collaboratorName",
        .event_time = "eventTime",
        .session_id = "sessionId",
        .trace = "trace",
    };
};
