const AgentsCriteria = @import("agents_criteria.zig").AgentsCriteria;

/// An object to define AgentsCriteria.
pub const MatchCriteria = struct {
    /// An object to define agentIds.
    agents_criteria: ?AgentsCriteria,

    pub const json_field_names = .{
        .agents_criteria = "AgentsCriteria",
    };
};
