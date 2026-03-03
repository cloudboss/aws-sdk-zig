const DefaultGatewayRouteRewrite = @import("default_gateway_route_rewrite.zig").DefaultGatewayRouteRewrite;

/// An object representing the beginning characters of the route to rewrite.
pub const HttpGatewayRoutePrefixRewrite = struct {
    /// The default prefix used to replace the incoming route prefix when rewritten.
    default_prefix: ?DefaultGatewayRouteRewrite = null,

    /// The value used to replace the incoming route prefix when rewritten.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_prefix = "defaultPrefix",
        .value = "value",
    };
};
