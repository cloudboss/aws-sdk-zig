const SearchContactsMatchType = @import("search_contacts_match_type.zig").SearchContactsMatchType;

/// The agent criteria to search for preferred agents on the routing criteria.
pub const SearchableAgentCriteriaStep = struct {
    /// The identifiers of agents used in preferred agents matching.
    agent_ids: ?[]const []const u8,

    /// The match type combining multiple agent criteria steps.
    match_type: ?SearchContactsMatchType,

    pub const json_field_names = .{
        .agent_ids = "AgentIds",
        .match_type = "MatchType",
    };
};
