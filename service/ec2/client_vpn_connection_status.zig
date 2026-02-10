const ClientVpnConnectionStatusCode = @import("client_vpn_connection_status_code.zig").ClientVpnConnectionStatusCode;

/// Describes the status of a client connection.
pub const ClientVpnConnectionStatus = struct {
    /// The state of the client connection.
    code: ?ClientVpnConnectionStatusCode,

    /// A message about the status of the client connection, if applicable.
    message: ?[]const u8,
};
