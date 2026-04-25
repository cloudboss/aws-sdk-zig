const HostPropertiesResponse = @import("host_properties_response.zig").HostPropertiesResponse;
const SessionLifecycleStatus = @import("session_lifecycle_status.zig").SessionLifecycleStatus;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const SessionLifecycleTargetStatus = @import("session_lifecycle_target_status.zig").SessionLifecycleTargetStatus;

/// The details of a session returned in a batch get operation.
pub const BatchGetSessionItem = struct {
    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The farm ID of the session.
    farm_id: []const u8,

    /// The fleet ID of the session.
    fleet_id: []const u8,

    /// The host properties for the session.
    host_properties: ?HostPropertiesResponse = null,

    /// The job ID of the session.
    job_id: []const u8,

    /// The life cycle status of the session.
    lifecycle_status: SessionLifecycleStatus,

    /// The session log.
    log: LogConfiguration,

    /// The queue ID of the session.
    queue_id: []const u8,

    /// The session ID.
    session_id: []const u8,

    /// The date and time the resource started running.
    started_at: i64,

    /// The target life cycle status for the session.
    target_lifecycle_status: ?SessionLifecycleTargetStatus = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    /// The worker ID of the session.
    worker_id: []const u8,

    /// The worker log for the session.
    worker_log: ?LogConfiguration = null,

    pub const json_field_names = .{
        .ended_at = "endedAt",
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .host_properties = "hostProperties",
        .job_id = "jobId",
        .lifecycle_status = "lifecycleStatus",
        .log = "log",
        .queue_id = "queueId",
        .session_id = "sessionId",
        .started_at = "startedAt",
        .target_lifecycle_status = "targetLifecycleStatus",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .worker_id = "workerId",
        .worker_log = "workerLog",
    };
};
