const AiUseCase = @import("ai_use_case.zig").AiUseCase;

/// The search criteria based on AI Agents metadata.
pub const AiAgentSearchCriteria = struct {
    /// A boolean flag indicating whether the contact initially handled by this AI
    /// agent was
    /// escalated to a human agent.
    ai_agent_escalated: ?bool = null,

    /// The use case or scenario for which the AI agent is involved in the contact.
    ai_use_case: ?AiUseCase = null,

    /// ID of the AI Agent that was involved in the contact.
    id: ?[]const u8 = null,

    /// Version of the AI agent that was involved in the contact. ID is required if
    /// VersionNumber
    /// is passed.
    version_number: ?i32 = null,

    pub const json_field_names = .{
        .ai_agent_escalated = "AiAgentEscalated",
        .ai_use_case = "AiUseCase",
        .id = "Id",
        .version_number = "VersionNumber",
    };
};
