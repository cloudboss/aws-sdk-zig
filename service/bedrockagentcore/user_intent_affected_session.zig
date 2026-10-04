/// A session associated with a user intent cluster.
pub const UserIntentAffectedSession = struct {
    /// The unique identifier of the session.
    session_id: []const u8,

    /// The user messages from this session that contributed to the intent cluster.
    user_messages: []const []const u8,

    pub const json_field_names = .{
        .session_id = "sessionId",
        .user_messages = "userMessages",
    };
};
