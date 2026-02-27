const HttpGatewayRouteRewrite = @import("http_gateway_route_rewrite.zig").HttpGatewayRouteRewrite;
const GatewayRouteTarget = @import("gateway_route_target.zig").GatewayRouteTarget;

/// An object that represents the action to take if a match is determined.
pub const HttpGatewayRouteAction = struct {
    /// The gateway route action to rewrite.
    rewrite: ?HttpGatewayRouteRewrite,

    /// An object that represents the target that traffic is routed to when a
    /// request matches the gateway route.
    target: GatewayRouteTarget,

    pub const json_field_names = .{
        .rewrite = "rewrite",
        .target = "target",
    };
};
