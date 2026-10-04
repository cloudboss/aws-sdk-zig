const Configuration = @import("configuration.zig").Configuration;
const SessionMonitoringConfiguration = @import("session_monitoring_configuration.zig").SessionMonitoringConfiguration;
const SessionState = @import("session_state.zig").SessionState;
const Tag = @import("tag.zig").Tag;

/// Detailed information about a Spark Connect session.
pub const Session = struct {
    /// The Amazon Web Services account ID that owns the session.
    account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the session.
    arn: []const u8,

    /// The ID of the cluster that the session belongs to.
    cluster_id: []const u8,

    /// The date and time that the session was created.
    created_at: ?i64 = null,

    /// The date and time that the session was terminated or failed.
    ended_at: ?i64 = null,

    /// The configuration overrides for the session. Only runtime configuration
    /// overrides are supported.
    engine_configurations: ?[]const Configuration = null,

    /// The execution role ARN for the session. Amazon EMR uses this role to access
    /// Amazon Web Services resources on your behalf during session execution.
    execution_role_arn: ?[]const u8 = null,

    /// The ID of the session.
    id: []const u8,

    /// The date and time that the session last entered the `IDLE` state.
    idle_since: ?i64 = null,

    /// The monitoring configuration for the session.
    monitoring_configuration: ?SessionMonitoringConfiguration = null,

    /// The name of the session, if one was provided at creation time.
    name: ?[]const u8 = null,

    /// The Amazon EMR release label of the cluster that the session is running on.
    release_label: ?[]const u8 = null,

    /// The Spark Connect server URL for the session. Use this URL with the
    /// `Credentials` returned by `GetSessionEndpoint` to connect directly to the
    /// session over VPC peering.
    server_url: ?[]const u8 = null,

    /// The idle timeout, in minutes. If the session is idle for this duration,
    /// Amazon EMR automatically terminates it.
    session_idle_timeout_in_minutes: ?i64 = null,

    /// The date and time that the session entered the `STARTED` state.
    started_at: ?i64 = null,

    /// The current state of the session. Valid values are `SUBMITTED`, `STARTING`,
    /// `STARTED`, `IDLE`, `BUSY`, `TERMINATING`, `TERMINATED`, and `FAILED`.
    state: SessionState,

    /// A human-readable message describing the most recent state change.
    state_change_reason: ?[]const u8 = null,

    /// The tags associated with the session.
    tags: ?[]const Tag = null,

    /// The date and time that the session was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .arn = "Arn",
        .cluster_id = "ClusterId",
        .created_at = "CreatedAt",
        .ended_at = "EndedAt",
        .engine_configurations = "EngineConfigurations",
        .execution_role_arn = "ExecutionRoleArn",
        .id = "Id",
        .idle_since = "IdleSince",
        .monitoring_configuration = "MonitoringConfiguration",
        .name = "Name",
        .release_label = "ReleaseLabel",
        .server_url = "ServerUrl",
        .session_idle_timeout_in_minutes = "SessionIdleTimeoutInMinutes",
        .started_at = "StartedAt",
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};
