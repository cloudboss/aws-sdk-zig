/// Configuration for SESSION_SUMMARY memory type enabled for the agent.
pub const SessionSummaryConfiguration = struct {
    /// Maximum number of recent session summaries to include in the agent's prompt
    /// context.
    max_recent_sessions: ?i32,

    pub const json_field_names = .{
        .max_recent_sessions = "maxRecentSessions",
    };
};
