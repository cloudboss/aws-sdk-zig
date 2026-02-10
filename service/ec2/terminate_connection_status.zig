const ClientVpnConnectionStatus = @import("client_vpn_connection_status.zig").ClientVpnConnectionStatus;

/// Information about a terminated Client VPN endpoint client connection.
pub const TerminateConnectionStatus = struct {
    /// The ID of the client connection.
    connection_id: ?[]const u8,

    /// A message about the status of the client connection, if applicable.
    current_status: ?ClientVpnConnectionStatus,

    /// The state of the client connection.
    previous_status: ?ClientVpnConnectionStatus,
};
