pub const AiUseCase = enum {
    agent_assistance,
    self_service,

    pub const json_field_names = .{
        .agent_assistance = "AgentAssistance",
        .self_service = "SelfService",
    };
};
