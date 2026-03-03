const VpnStaticRouteSource = @import("vpn_static_route_source.zig").VpnStaticRouteSource;
const VpnState = @import("vpn_state.zig").VpnState;

/// Describes a static route for a VPN connection.
pub const VpnStaticRoute = struct {
    /// The CIDR block associated with the local subnet of the customer data center.
    destination_cidr_block: ?[]const u8 = null,

    /// Indicates how the routes were provided.
    source: ?VpnStaticRouteSource = null,

    /// The current state of the static route.
    state: ?VpnState = null,
};
