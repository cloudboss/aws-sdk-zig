/// Contains summary information about a threat model.
pub const ThreatModelSummary = struct {
    /// The unique identifier of the agent space that contains the threat model.
    agent_space_id: []const u8,

    /// The date and time the threat model was created, in UTC format.
    created_at: ?i64 = null,

    /// The unique identifier of the threat model.
    threat_model_id: []const u8,

    /// The title of the threat model.
    title: []const u8,

    /// The date and time the threat model was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .created_at = "createdAt",
        .threat_model_id = "threatModelId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
