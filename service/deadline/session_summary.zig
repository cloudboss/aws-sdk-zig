const SessionLifecycleStatus = @import("session_lifecycle_status.zig").SessionLifecycleStatus;
const SessionLifecycleTargetStatus = @import("session_lifecycle_target_status.zig").SessionLifecycleTargetStatus;

/// The summary of a session.
pub const SessionSummary = struct {
    /// The date and time the resource ended running.
    ended_at: ?i64,

    /// The fleet ID.
    fleet_id: []const u8,

    /// The life cycle status for the session.
    lifecycle_status: SessionLifecycleStatus,

    /// The session ID.
    session_id: []const u8,

    /// The date and time the resource started running.
    started_at: i64,

    /// The target life cycle status for the session.
    target_lifecycle_status: ?SessionLifecycleTargetStatus,

    /// The date and time the resource was updated.
    updated_at: ?i64,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8,

    /// The worker ID.
    worker_id: []const u8,

    pub const json_field_names = .{
        .ended_at = "endedAt",
        .fleet_id = "fleetId",
        .lifecycle_status = "lifecycleStatus",
        .session_id = "sessionId",
        .started_at = "startedAt",
        .target_lifecycle_status = "targetLifecycleStatus",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .worker_id = "workerId",
    };
};
