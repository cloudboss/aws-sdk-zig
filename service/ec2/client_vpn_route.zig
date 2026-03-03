const ClientVpnRouteStatus = @import("client_vpn_route_status.zig").ClientVpnRouteStatus;

/// Information about a Client VPN endpoint route.
pub const ClientVpnRoute = struct {
    /// The ID of the Client VPN endpoint with which the route is associated.
    client_vpn_endpoint_id: ?[]const u8 = null,

    /// A brief description of the route.
    description: ?[]const u8 = null,

    /// The IPv4 address range, in CIDR notation, of the route destination.
    destination_cidr: ?[]const u8 = null,

    /// Indicates how the route was associated with the Client VPN endpoint.
    /// `associate` indicates that the route was automatically added when the target
    /// network
    /// was associated with the Client VPN endpoint. `add-route` indicates that the
    /// route
    /// was manually added using the **CreateClientVpnRoute** action.
    origin: ?[]const u8 = null,

    /// The current state of the route.
    status: ?ClientVpnRouteStatus = null,

    /// The ID of the subnet through which traffic is routed.
    target_subnet: ?[]const u8 = null,

    /// The route type.
    @"type": ?[]const u8 = null,
};
