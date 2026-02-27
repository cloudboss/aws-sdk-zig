const HttpGatewayRouteAction = @import("http_gateway_route_action.zig").HttpGatewayRouteAction;
const HttpGatewayRouteMatch = @import("http_gateway_route_match.zig").HttpGatewayRouteMatch;

/// An object that represents an HTTP gateway route.
pub const HttpGatewayRoute = struct {
    /// An object that represents the action to take if a match is determined.
    action: HttpGatewayRouteAction,

    /// An object that represents the criteria for determining a request match.
    match: HttpGatewayRouteMatch,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
    };
};
