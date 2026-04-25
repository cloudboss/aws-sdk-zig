const AgentCardDefinition = @import("agent_card_definition.zig").AgentCardDefinition;

/// The A2A (Agent-to-Agent) descriptor configuration for a registry record.
pub const A2aDescriptor = struct {
    /// The agent card definition that describes the agent's capabilities and
    /// interface.
    agent_card: AgentCardDefinition,

    pub const json_field_names = .{
        .agent_card = "agentCard",
    };
};
