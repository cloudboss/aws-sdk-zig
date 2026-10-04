const ExecutionSummaryAffectedSession = @import("execution_summary_affected_session.zig").ExecutionSummaryAffectedSession;

/// A cluster of similar execution patterns identified across sessions.
pub const ExecutionSummaryCluster = struct {
    /// The number of sessions with this execution pattern.
    affected_session_count: i32,

    /// The list of sessions with this execution pattern.
    affected_sessions: []const ExecutionSummaryAffectedSession,

    /// The unique identifier of the execution summary cluster.
    cluster_id: i32,

    /// A description of the execution pattern.
    description: []const u8,

    /// The name of the execution pattern cluster.
    name: []const u8,

    pub const json_field_names = .{
        .affected_session_count = "affectedSessionCount",
        .affected_sessions = "affectedSessions",
        .cluster_id = "clusterId",
        .description = "description",
        .name = "name",
    };
};
