const SessionLifecycleStatus = @import("session_lifecycle_status.zig").SessionLifecycleStatus;
const SessionLifecycleTargetStatus = @import("session_lifecycle_target_status.zig").SessionLifecycleTargetStatus;

/// Summarizes the session for a particular worker.
pub const WorkerSessionSummary = struct {
    /// The date and time the resource ended running.
    ended_at: ?i64,

    /// The job ID for the job associated with the worker's session.
    job_id: []const u8,

    /// The life cycle status for the worker's session.
    lifecycle_status: SessionLifecycleStatus,

    /// The queue ID for the queue associated to the worker.
    queue_id: []const u8,

    /// The session ID for the session action.
    session_id: []const u8,

    /// The date and time the resource started running.
    started_at: i64,

    /// The life cycle status
    target_lifecycle_status: ?SessionLifecycleTargetStatus,

    pub const json_field_names = .{
        .ended_at = "endedAt",
        .job_id = "jobId",
        .lifecycle_status = "lifecycleStatus",
        .queue_id = "queueId",
        .session_id = "sessionId",
        .started_at = "startedAt",
        .target_lifecycle_status = "targetLifecycleStatus",
    };
};
