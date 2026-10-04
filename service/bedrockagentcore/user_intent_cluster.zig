const UserIntentAffectedSession = @import("user_intent_affected_session.zig").UserIntentAffectedSession;

/// A cluster of similar user intents identified across sessions.
pub const UserIntentCluster = struct {
    /// The number of sessions with this user intent.
    affected_session_count: i32,

    /// The list of sessions with this user intent.
    affected_sessions: []const UserIntentAffectedSession,

    /// The unique identifier of the user intent cluster.
    cluster_id: i32,

    /// A description of the user intent pattern.
    description: []const u8,

    /// The name of the user intent cluster.
    name: []const u8,

    pub const json_field_names = .{
        .affected_session_count = "affectedSessionCount",
        .affected_sessions = "affectedSessions",
        .cluster_id = "clusterId",
        .description = "description",
        .name = "name",
    };
};
