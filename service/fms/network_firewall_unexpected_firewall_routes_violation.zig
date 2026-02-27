const Route = @import("route.zig").Route;

/// Violation detail for an unexpected route that's present in a route table.
pub const NetworkFirewallUnexpectedFirewallRoutesViolation = struct {
    /// The endpoint of the firewall.
    firewall_endpoint: ?[]const u8,

    /// The subnet ID for the firewall.
    firewall_subnet_id: ?[]const u8,

    /// The ID of the route table.
    route_table_id: ?[]const u8,

    /// The routes that are in violation.
    violating_routes: ?[]const Route,

    /// Information about the VPC ID.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .firewall_endpoint = "FirewallEndpoint",
        .firewall_subnet_id = "FirewallSubnetId",
        .route_table_id = "RouteTableId",
        .violating_routes = "ViolatingRoutes",
        .vpc_id = "VpcId",
    };
};
