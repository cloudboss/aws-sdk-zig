/// The AI agent that participates in the contact, including its identifier.
pub const AiAgentInput = struct {
    /// The identifier of the AI agent that participates in the contact.
    ai_agent_id: []const u8,

    pub const json_field_names = .{
        .ai_agent_id = "AiAgentId",
    };
};
