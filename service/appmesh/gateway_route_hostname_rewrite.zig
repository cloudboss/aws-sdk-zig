const DefaultGatewayRouteRewrite = @import("default_gateway_route_rewrite.zig").DefaultGatewayRouteRewrite;

/// An object representing the gateway route host name to rewrite.
pub const GatewayRouteHostnameRewrite = struct {
    /// The default target host name to write to.
    default_target_hostname: ?DefaultGatewayRouteRewrite = null,

    pub const json_field_names = .{
        .default_target_hostname = "defaultTargetHostname",
    };
};
