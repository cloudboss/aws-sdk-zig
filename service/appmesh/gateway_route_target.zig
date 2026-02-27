const GatewayRouteVirtualService = @import("gateway_route_virtual_service.zig").GatewayRouteVirtualService;

/// An object that represents a gateway route target.
pub const GatewayRouteTarget = struct {
    /// The port number of the gateway route target.
    port: ?i32,

    /// An object that represents a virtual service gateway route target.
    virtual_service: GatewayRouteVirtualService,

    pub const json_field_names = .{
        .port = "port",
        .virtual_service = "virtualService",
    };
};
