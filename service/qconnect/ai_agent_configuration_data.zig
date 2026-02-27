/// A type that specifies the AI Agent ID configuration data when mapping an AI
/// Agents to be used for an AI Agent type on a session or assistant.
pub const AIAgentConfigurationData = struct {
    /// The ID of the AI Agent to be configured.
    ai_agent_id: []const u8,

    pub const json_field_names = .{
        .ai_agent_id = "aiAgentId",
    };
};
