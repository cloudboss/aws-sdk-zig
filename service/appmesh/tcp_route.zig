const TcpRouteAction = @import("tcp_route_action.zig").TcpRouteAction;
const TcpRouteMatch = @import("tcp_route_match.zig").TcpRouteMatch;
const TcpTimeout = @import("tcp_timeout.zig").TcpTimeout;

/// An object that represents a TCP route type.
pub const TcpRoute = struct {
    /// The action to take if a match is determined.
    action: TcpRouteAction,

    /// An object that represents the criteria for determining a request match.
    match: ?TcpRouteMatch = null,

    /// An object that represents types of timeouts.
    timeout: ?TcpTimeout = null,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
        .timeout = "timeout",
    };
};
