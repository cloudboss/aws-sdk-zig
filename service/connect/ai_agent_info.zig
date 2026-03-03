const AiUseCase = @import("ai_use_case.zig").AiUseCase;

/// Information of the AI agent involved in the contact.
pub const AiAgentInfo = struct {
    /// A boolean flag indicating whether the contact initially handled by this AI
    /// agent was escalated to a human
    /// agent.
    ai_agent_escalated: bool = false,

    /// The unique identifier that specifies both the AI agent ID and its version
    /// number that was involved in the
    /// contact
    ai_agent_version_id: ?[]const u8 = null,

    /// The use case or scenario for which the AI agent is involved in the contact
    ai_use_case: ?AiUseCase = null,

    pub const json_field_names = .{
        .ai_agent_escalated = "AiAgentEscalated",
        .ai_agent_version_id = "AiAgentVersionId",
        .ai_use_case = "AiUseCase",
    };
};
