const SearchableAgentCriteriaStep = @import("searchable_agent_criteria_step.zig").SearchableAgentCriteriaStep;

/// Routing criteria of the contact to match on.
pub const SearchableRoutingCriteriaStep = struct {
    /// Agent matching the routing step of the routing criteria
    agent_criteria: ?SearchableAgentCriteriaStep = null,

    pub const json_field_names = .{
        .agent_criteria = "AgentCriteria",
    };
};
