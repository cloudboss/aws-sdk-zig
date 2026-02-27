const RelayConversationHistory = @import("relay_conversation_history.zig").RelayConversationHistory;

/// Settings of an inline collaborator agent.
pub const CollaboratorConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the inline collaborator agent.
    agent_alias_arn: ?[]const u8,

    /// Instructions that tell the inline collaborator agent what it should do and
    /// how it should interact with users.
    collaborator_instruction: []const u8,

    /// Name of the inline collaborator agent which must be the same name as
    /// specified for `agentName`.
    collaborator_name: []const u8,

    /// A relay conversation history for the inline collaborator agent.
    relay_conversation_history: ?RelayConversationHistory,

    pub const json_field_names = .{
        .agent_alias_arn = "agentAliasArn",
        .collaborator_instruction = "collaboratorInstruction",
        .collaborator_name = "collaboratorName",
        .relay_conversation_history = "relayConversationHistory",
    };
};
