const RouteServerBfdState = @import("route_server_bfd_state.zig").RouteServerBfdState;

/// The current status of Bidirectional Forwarding Detection (BFD) for a BGP
/// session.
pub const RouteServerBfdStatus = struct {
    /// The operational status of the BFD session.
    status: ?RouteServerBfdState,
};
