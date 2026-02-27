const AgentDescriptor = @import("agent_descriptor.zig").AgentDescriptor;
const RelayConversationHistory = @import("relay_conversation_history.zig").RelayConversationHistory;

/// An agent collaborator.
pub const AgentCollaborator = struct {
    /// The collaborator's agent descriptor.
    agent_descriptor: AgentDescriptor,

    /// The collaborator's agent ID.
    agent_id: []const u8,

    /// The collaborator's agent version.
    agent_version: []const u8,

    /// The collaborator's client token.
    client_token: ?[]const u8,

    /// The collaborator's instructions.
    collaboration_instruction: []const u8,

    /// The collaborator's collaborator ID.
    collaborator_id: []const u8,

    /// The collaborator's collaborator name.
    collaborator_name: []const u8,

    /// When the collaborator was created.
    created_at: i64,

    /// When the collaborator was updated.
    last_updated_at: i64,

    /// The collaborator's relay conversation history.
    relay_conversation_history: ?RelayConversationHistory,

    pub const json_field_names = .{
        .agent_descriptor = "agentDescriptor",
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .client_token = "clientToken",
        .collaboration_instruction = "collaborationInstruction",
        .collaborator_id = "collaboratorId",
        .collaborator_name = "collaboratorName",
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .relay_conversation_history = "relayConversationHistory",
    };
};
