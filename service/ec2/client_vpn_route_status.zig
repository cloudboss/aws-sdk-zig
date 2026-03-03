const ClientVpnRouteStatusCode = @import("client_vpn_route_status_code.zig").ClientVpnRouteStatusCode;

/// Describes the state of a Client VPN endpoint route.
pub const ClientVpnRouteStatus = struct {
    /// The state of the Client VPN endpoint route.
    code: ?ClientVpnRouteStatusCode = null,

    /// A message about the status of the Client VPN endpoint route, if applicable.
    message: ?[]const u8 = null,
};
