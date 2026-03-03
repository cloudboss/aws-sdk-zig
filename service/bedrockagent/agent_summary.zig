const AgentStatus = @import("agent_status.zig").AgentStatus;
const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;

/// Contains details about an agent.
pub const AgentSummary = struct {
    /// The unique identifier of the agent.
    agent_id: []const u8,

    /// The name of the agent.
    agent_name: []const u8,

    /// The status of the agent.
    agent_status: AgentStatus,

    /// The description of the agent.
    description: ?[]const u8 = null,

    /// Details about the guardrail associated with the agent.
    guardrail_configuration: ?GuardrailConfiguration = null,

    /// The latest version of the agent.
    latest_agent_version: ?[]const u8 = null,

    /// The time at which the agent was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .agent_name = "agentName",
        .agent_status = "agentStatus",
        .description = "description",
        .guardrail_configuration = "guardrailConfiguration",
        .latest_agent_version = "latestAgentVersion",
        .updated_at = "updatedAt",
    };
};
