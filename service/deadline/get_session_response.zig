const HostPropertiesResponse = @import("host_properties_response.zig").HostPropertiesResponse;
const SessionLifecycleStatus = @import("session_lifecycle_status.zig").SessionLifecycleStatus;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const SessionLifecycleTargetStatus = @import("session_lifecycle_target_status.zig").SessionLifecycleTargetStatus;

/// Session lifecycle/status fields, ordered after IDs in session shapes.
pub const GetSessionResponse = struct {
    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The fleet ID for the session.
    fleet_id: []const u8,

    /// Provides the Amazon EC2 properties of the host.
    host_properties: ?HostPropertiesResponse = null,

    /// The life cycle status of the session.
    lifecycle_status: SessionLifecycleStatus,

    /// The session log.
    log: LogConfiguration,

    /// The session ID.
    session_id: []const u8,

    /// The date and time the resource started running.
    started_at: i64,

    /// The life cycle status with which the session started.
    target_lifecycle_status: ?SessionLifecycleTargetStatus = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    /// The worker ID for the session.
    worker_id: []const u8,

    /// The worker log for the session.
    worker_log: ?LogConfiguration = null,

    pub const json_field_names = .{
        .ended_at = "endedAt",
        .fleet_id = "fleetId",
        .host_properties = "hostProperties",
        .lifecycle_status = "lifecycleStatus",
        .log = "log",
        .session_id = "sessionId",
        .started_at = "startedAt",
        .target_lifecycle_status = "targetLifecycleStatus",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .worker_id = "workerId",
        .worker_log = "workerLog",
    };
};
