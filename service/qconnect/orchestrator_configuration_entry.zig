/// An entry in the orchestrator configuration list.
pub const OrchestratorConfigurationEntry = struct {
    /// The identifier of the AI Agent in the orchestrator configuration.
    ai_agent_id: ?[]const u8 = null,

    /// The use case for the orchestrator configuration. (for example
    /// Connect.SelfService, Connect.AgentAssistance)
    orchestrator_use_case: []const u8,

    pub const json_field_names = .{
        .ai_agent_id = "aiAgentId",
        .orchestrator_use_case = "orchestratorUseCase",
    };
};
