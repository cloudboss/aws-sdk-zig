const GatewayRouteStatusCode = @import("gateway_route_status_code.zig").GatewayRouteStatusCode;

/// An object that represents the current status of a gateway route.
pub const GatewayRouteStatus = struct {
    /// The current status for the gateway route.
    status: GatewayRouteStatusCode,

    pub const json_field_names = .{
        .status = "status",
    };
};
