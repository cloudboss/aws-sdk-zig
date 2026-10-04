const AffectedSession = @import("affected_session.zig").AffectedSession;

/// A cluster of similar root causes identified within a failure subcategory.
pub const RootCauseCluster = struct {
    /// The number of sessions affected by this root cause.
    affected_session_count: i32,

    /// The list of sessions affected by this root cause.
    affected_sessions: []const AffectedSession,

    /// The unique identifier of the root cause cluster.
    cluster_id: i32,

    /// The name of the root cause cluster.
    name: []const u8,

    /// The recommended fix for this root cause.
    recommendation: []const u8,

    /// The root cause explanation for this cluster of failures.
    root_cause: []const u8,

    pub const json_field_names = .{
        .affected_session_count = "affectedSessionCount",
        .affected_sessions = "affectedSessions",
        .cluster_id = "clusterId",
        .name = "name",
        .recommendation = "recommendation",
        .root_cause = "rootCause",
    };
};
