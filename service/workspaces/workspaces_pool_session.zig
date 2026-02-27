const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const SessionConnectionState = @import("session_connection_state.zig").SessionConnectionState;
const NetworkAccessConfiguration = @import("network_access_configuration.zig").NetworkAccessConfiguration;

/// Describes a pool session.
pub const WorkspacesPoolSession = struct {
    /// The authentication method. The user is authenticated using a
    /// WorkSpaces Pools URL (API) or SAML 2.0 federation (SAML).
    authentication_type: ?AuthenticationType,

    /// Specifies whether a user is connected to the pool session.
    connection_state: ?SessionConnectionState,

    /// The time that the pool session ended.
    expiration_time: ?i64,

    /// The identifier for the instance hosting the session.
    instance_id: ?[]const u8,

    /// Describes the network details of the pool.
    network_access_configuration: ?NetworkAccessConfiguration,

    /// The identifier of the pool.
    pool_id: []const u8,

    /// The identifier of the session.
    session_id: []const u8,

    /// The time that the pool sission started.
    start_time: ?i64,

    /// The identifier of the user.
    user_id: []const u8,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .connection_state = "ConnectionState",
        .expiration_time = "ExpirationTime",
        .instance_id = "InstanceId",
        .network_access_configuration = "NetworkAccessConfiguration",
        .pool_id = "PoolId",
        .session_id = "SessionId",
        .start_time = "StartTime",
        .user_id = "UserId",
    };
};
