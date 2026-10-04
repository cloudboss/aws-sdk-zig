/// A type that specifies the AI Agent ID configuration data when mapping an AI
/// Agents to be used for an AI Agent type on a session or assistant.
pub const AIAgentConfigurationData = struct {
    /// The ID of the AI Agent to be configured.
    ai_agent_id: []const u8,

    /// Indicates whether the AI Agent configured for this AI Agent type is enabled.
    /// When this value is omitted or set to true, the configured AI Agent runs;
    /// when set to false, the AI Agent ID is retained but no AI Agent runs for the
    /// AI Agent type. Setting this value to false is currently supported only for
    /// the `ANSWER_RECOMMENDATION` AI Agent type; other requests to set it to false
    /// are rejected with a validation error.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .ai_agent_id = "aiAgentId",
        .enabled = "enabled",
    };
};
