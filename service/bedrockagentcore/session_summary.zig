/// Contains summary information about a session in an AgentCore Memory
/// resource.
pub const SessionSummary = struct {
    /// The identifier of the actor associated with the session.
    actor_id: []const u8,

    /// The timestamp when the session was created.
    created_at: i64,

    /// The unique identifier of the session.
    session_id: []const u8,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .created_at = "createdAt",
        .session_id = "sessionId",
    };
};
