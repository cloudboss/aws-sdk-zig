const RouteServerBgpState = @import("route_server_bgp_state.zig").RouteServerBgpState;

/// The current status of a BGP session.
pub const RouteServerBgpStatus = struct {
    /// The operational status of the BGP session. The status enables you to monitor
    /// session liveness if you lack monitoring on your router/appliance.
    status: ?RouteServerBgpState,
};
