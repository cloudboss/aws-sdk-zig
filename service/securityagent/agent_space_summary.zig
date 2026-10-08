/// Contains summary information about an agent space.
pub const AgentSpaceSummary = struct {
    /// The unique identifier of the agent space.
    agent_space_id: []const u8,

    /// The date and time the agent space was created, in UTC format.
    created_at: ?i64 = null,

    /// The name of the agent space.
    name: []const u8,

    /// The date and time the agent space was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .created_at = "createdAt",
        .name = "name",
        .updated_at = "updatedAt",
    };
};
