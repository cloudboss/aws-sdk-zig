/// A union that identifies a collaborator agent to engage. Specify either an
/// Amazon Connect AI Agent or a third-party agent.
pub const AgentTarget = union(enum) {
    /// The identifier of an Amazon Connect AI Agent to use as the collaborator
    /// agent.
    ai_agent_id: ?[]const u8,
    /// The identifier of a third-party agent to use as the collaborator agent.
    application_id: ?[]const u8,

    pub const json_field_names = .{
        .ai_agent_id = "aiAgentId",
        .application_id = "applicationId",
    };
};
