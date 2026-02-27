const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// The state of a connection.
pub const ConnectionState = struct {
    /// The last time the connection status was updated.
    last_updated_at: ?i64,

    /// The connection status of the tunnel. Valid values are `CONNECTED` and
    /// `DISCONNECTED`.
    status: ?ConnectionStatus,

    pub const json_field_names = .{
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
    };
};
