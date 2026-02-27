/// The specification of an agent turn.
pub const AgentTurnSpecification = struct {
    /// The agent prompt for the agent turn in a test set.
    agent_prompt: []const u8,

    pub const json_field_names = .{
        .agent_prompt = "agentPrompt",
    };
};
