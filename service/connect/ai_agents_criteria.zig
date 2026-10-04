const AiAgentSearchCriteria = @import("ai_agent_search_criteria.zig").AiAgentSearchCriteria;

/// AI Agent search criteria definitions.
pub const AiAgentsCriteria = struct {
    /// The list of criteria based on AI Agent metadata.
    criteria: ?[]const AiAgentSearchCriteria = null,

    pub const json_field_names = .{
        .criteria = "Criteria",
    };
};
