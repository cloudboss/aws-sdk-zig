const AgentCardDefinition = @import("agent_card_definition.zig").AgentCardDefinition;

/// The Agent-to-Agent (A2A) protocol descriptor for a registry record. Contains
/// the agent card definition as defined by the A2A protocol specification.
pub const A2aDescriptor = struct {
    /// The agent card definition for the A2A agent, as defined by the A2A protocol
    /// specification.
    agent_card: ?AgentCardDefinition = null,

    pub const json_field_names = .{
        .agent_card = "agentCard",
    };
};
