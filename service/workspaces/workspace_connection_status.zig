const ConnectionState = @import("connection_state.zig").ConnectionState;

/// Describes the connection status of a WorkSpace.
pub const WorkspaceConnectionStatus = struct {
    /// The connection state of the WorkSpace. The connection state is unknown if
    /// the WorkSpace
    /// is stopped.
    connection_state: ?ConnectionState = null,

    /// The timestamp of the connection status check.
    connection_state_check_timestamp: ?i64 = null,

    /// The timestamp of the last known user connection.
    last_known_user_connection_timestamp: ?i64 = null,

    /// The identifier of the WorkSpace.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_state = "ConnectionState",
        .connection_state_check_timestamp = "ConnectionStateCheckTimestamp",
        .last_known_user_connection_timestamp = "LastKnownUserConnectionTimestamp",
        .workspace_id = "WorkspaceId",
    };
};
