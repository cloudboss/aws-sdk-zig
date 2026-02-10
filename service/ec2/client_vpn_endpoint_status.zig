const ClientVpnEndpointStatusCode = @import("client_vpn_endpoint_status_code.zig").ClientVpnEndpointStatusCode;

/// Describes the state of a Client VPN endpoint.
pub const ClientVpnEndpointStatus = struct {
    /// The state of the Client VPN endpoint. Possible states include:
    ///
    /// * `pending-associate` - The Client VPN endpoint has been created but no
    ///   target networks
    /// have been associated. The Client VPN endpoint cannot accept connections.
    ///
    /// * `available` - The Client VPN endpoint has been created and a target
    ///   network has been
    /// associated. The Client VPN endpoint can accept connections.
    ///
    /// * `deleting` - The Client VPN endpoint is being deleted. The Client VPN
    ///   endpoint cannot accept
    /// connections.
    ///
    /// * `deleted` - The Client VPN endpoint has been deleted. The Client VPN
    ///   endpoint cannot accept
    /// connections.
    code: ?ClientVpnEndpointStatusCode,

    /// A message about the status of the Client VPN endpoint.
    message: ?[]const u8,
};
