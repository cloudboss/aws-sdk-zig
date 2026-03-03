const GatewayRouteHostnameRewrite = @import("gateway_route_hostname_rewrite.zig").GatewayRouteHostnameRewrite;

/// An object that represents the gateway route to rewrite.
pub const GrpcGatewayRouteRewrite = struct {
    /// The host name of the gateway route to rewrite.
    hostname: ?GatewayRouteHostnameRewrite = null,

    pub const json_field_names = .{
        .hostname = "hostname",
    };
};
