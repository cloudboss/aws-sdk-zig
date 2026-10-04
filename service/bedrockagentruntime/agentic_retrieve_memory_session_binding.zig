/// The short-term memory session that this retrieval reads from and writes to.
pub const AgenticRetrieveMemorySessionBinding = struct {
    /// The identifier of the end user or agent that the session belongs to. This
    /// identifier scopes session history so that one actor's history is never
    /// returned for another. You are responsible for sending the correct actor
    /// value.
    actor_id: []const u8,

    /// The identifier of the session to restore and continue. You are responsible
    /// for sending the correct session value.
    session_id: []const u8,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .session_id = "sessionId",
    };
};
