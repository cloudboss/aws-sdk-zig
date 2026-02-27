/// Reference information for a suggested message.
pub const SuggestedMessageReference = struct {
    /// The Amazon Resource Name (ARN) of the AI Agent that generated the suggested
    /// message.
    ai_agent_arn: []const u8,

    /// The identifier of the AI Agent that generated the suggested message.
    ai_agent_id: []const u8,

    pub const json_field_names = .{
        .ai_agent_arn = "aiAgentArn",
        .ai_agent_id = "aiAgentId",
    };
};
