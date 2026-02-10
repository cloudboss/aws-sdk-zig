const RouteServerPropagationState = @import("route_server_propagation_state.zig").RouteServerPropagationState;

/// Describes the route propagation configuration between a route server and a
/// route table.
///
/// When enabled, route server propagation installs the routes in the FIB on the
/// route table you've specified. Route server supports IPv4 and IPv6 route
/// propagation.
pub const RouteServerPropagation = struct {
    /// The ID of the route server configured for route propagation.
    route_server_id: ?[]const u8,

    /// The ID of the route table configured for route server propagation.
    route_table_id: ?[]const u8,

    /// The current state of route propagation.
    state: ?RouteServerPropagationState,
};
