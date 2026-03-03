const FailbackLaunchType = @import("failback_launch_type.zig").FailbackLaunchType;
const FailbackState = @import("failback_state.zig").FailbackState;

/// An object representing failback related information of the Recovery
/// Instance.
pub const RecoveryInstanceFailback = struct {
    /// The date and time the agent on the Recovery Instance was last seen by the
    /// service.
    agent_last_seen_by_service_date_time: ?[]const u8 = null,

    /// The amount of time that the Recovery Instance has been replicating for.
    elapsed_replication_duration: ?[]const u8 = null,

    /// The ID of the failback client that this Recovery Instance is associated
    /// with.
    failback_client_id: ?[]const u8 = null,

    /// The date and time that the failback client was last seen by the service.
    failback_client_last_seen_by_service_date_time: ?[]const u8 = null,

    /// The date and time that the failback initiation started.
    failback_initiation_time: ?[]const u8 = null,

    /// The Job ID of the last failback log for this Recovery Instance.
    failback_job_id: ?[]const u8 = null,

    /// The launch type (Recovery / Drill) of the last launch for the failback
    /// replication of this recovery instance.
    failback_launch_type: ?FailbackLaunchType = null,

    /// Whether we are failing back to the original Source Server for this Recovery
    /// Instance.
    failback_to_original_server: ?bool = null,

    /// The date and time of the first byte that was replicated from the Recovery
    /// Instance.
    first_byte_date_time: ?[]const u8 = null,

    /// The state of the failback process that this Recovery Instance is in.
    state: ?FailbackState = null,

    pub const json_field_names = .{
        .agent_last_seen_by_service_date_time = "agentLastSeenByServiceDateTime",
        .elapsed_replication_duration = "elapsedReplicationDuration",
        .failback_client_id = "failbackClientID",
        .failback_client_last_seen_by_service_date_time = "failbackClientLastSeenByServiceDateTime",
        .failback_initiation_time = "failbackInitiationTime",
        .failback_job_id = "failbackJobID",
        .failback_launch_type = "failbackLaunchType",
        .failback_to_original_server = "failbackToOriginalServer",
        .first_byte_date_time = "firstByteDateTime",
        .state = "state",
    };
};
