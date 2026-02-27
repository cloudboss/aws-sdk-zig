const Route = @import("route.zig").Route;

/// Violation detail for an unexpected gateway route that’s present in a route
/// table.
pub const NetworkFirewallUnexpectedGatewayRoutesViolation = struct {
    /// Information about the gateway ID.
    gateway_id: ?[]const u8,

    /// Information about the route table.
    route_table_id: ?[]const u8,

    /// The routes that are in violation.
    violating_routes: ?[]const Route,

    /// Information about the VPC ID.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .gateway_id = "GatewayId",
        .route_table_id = "RouteTableId",
        .violating_routes = "ViolatingRoutes",
        .vpc_id = "VpcId",
    };
};
