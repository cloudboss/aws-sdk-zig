const AgentStatus = @import("agent_status.zig").AgentStatus;
const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;

/// Contains details about a version of an agent.
pub const AgentVersionSummary = struct {
    /// The name of the agent to which the version belongs.
    agent_name: []const u8,

    /// The status of the agent to which the version belongs.
    agent_status: AgentStatus,

    /// The version of the agent.
    agent_version: []const u8,

    /// The time at which the version was created.
    created_at: i64,

    /// The description of the version of the agent.
    description: ?[]const u8,

    /// Details about the guardrail associated with the agent.
    guardrail_configuration: ?GuardrailConfiguration,

    /// The time at which the version was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_name = "agentName",
        .agent_status = "agentStatus",
        .agent_version = "agentVersion",
        .created_at = "createdAt",
        .description = "description",
        .guardrail_configuration = "guardrailConfiguration",
        .updated_at = "updatedAt",
    };
};
