const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;
const ConnectionType = @import("connection_type.zig").ConnectionType;

/// Describes connection health.
pub const ConnectionHealth = struct {
    /// The connection status.
    status: ?ConnectionStatus,

    /// The time the status was last updated.
    timestamp: ?i64,

    /// The connection type.
    @"type": ?ConnectionType,

    pub const json_field_names = .{
        .status = "Status",
        .timestamp = "Timestamp",
        .@"type" = "Type",
    };
};
