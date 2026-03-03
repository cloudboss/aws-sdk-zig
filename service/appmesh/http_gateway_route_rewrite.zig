const GatewayRouteHostnameRewrite = @import("gateway_route_hostname_rewrite.zig").GatewayRouteHostnameRewrite;
const HttpGatewayRoutePathRewrite = @import("http_gateway_route_path_rewrite.zig").HttpGatewayRoutePathRewrite;
const HttpGatewayRoutePrefixRewrite = @import("http_gateway_route_prefix_rewrite.zig").HttpGatewayRoutePrefixRewrite;

/// An object representing the gateway route to rewrite.
pub const HttpGatewayRouteRewrite = struct {
    /// The host name to rewrite.
    hostname: ?GatewayRouteHostnameRewrite = null,

    /// The path to rewrite.
    path: ?HttpGatewayRoutePathRewrite = null,

    /// The specified beginning characters to rewrite.
    prefix: ?HttpGatewayRoutePrefixRewrite = null,

    pub const json_field_names = .{
        .hostname = "hostname",
        .path = "path",
        .prefix = "prefix",
    };
};
