const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const SessionConnectionState = @import("session_connection_state.zig").SessionConnectionState;
const InstanceDrainStatus = @import("instance_drain_status.zig").InstanceDrainStatus;
const NetworkAccessConfiguration = @import("network_access_configuration.zig").NetworkAccessConfiguration;
const SessionState = @import("session_state.zig").SessionState;

/// Describes a streaming session.
pub const Session = struct {
    /// The authentication method. The user is authenticated using a streaming URL
    /// (`API`) or SAML 2.0 federation (`SAML`).
    authentication_type: ?AuthenticationType = null,

    /// Specifies whether a user is connected to the streaming session.
    connection_state: ?SessionConnectionState = null,

    /// The name of the fleet for the streaming session.
    fleet_name: []const u8,

    /// The identifier of the streaming session.
    id: []const u8,

    /// The drain status of the instance hosting the streaming session. This only
    /// applies to multi-session fleets.
    instance_drain_status: ?InstanceDrainStatus = null,

    /// The identifier for the instance hosting the session.
    instance_id: ?[]const u8 = null,

    /// The time when the streaming session is set to expire. This time is based on
    /// the `MaxUserDurationinSeconds` value, which determines the maximum length of
    /// time that a streaming session can run. A streaming session might end earlier
    /// than the time specified in `SessionMaxExpirationTime`, when the
    /// `DisconnectTimeOutInSeconds` elapses or the user chooses to end his or her
    /// session. If the `DisconnectTimeOutInSeconds` elapses, or the user chooses to
    /// end his or her session, the streaming instance is terminated and the
    /// streaming session ends.
    max_expiration_time: ?i64 = null,

    /// The network details for the streaming session.
    network_access_configuration: ?NetworkAccessConfiguration = null,

    /// The name of the stack for the streaming session.
    stack_name: []const u8,

    /// The time when a streaming instance is dedicated for the user.
    start_time: ?i64 = null,

    /// The current state of the streaming session.
    state: SessionState,

    /// The identifier of the user for whom the session was created.
    user_id: []const u8,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .connection_state = "ConnectionState",
        .fleet_name = "FleetName",
        .id = "Id",
        .instance_drain_status = "InstanceDrainStatus",
        .instance_id = "InstanceId",
        .max_expiration_time = "MaxExpirationTime",
        .network_access_configuration = "NetworkAccessConfiguration",
        .stack_name = "StackName",
        .start_time = "StartTime",
        .state = "State",
        .user_id = "UserId",
    };
};
