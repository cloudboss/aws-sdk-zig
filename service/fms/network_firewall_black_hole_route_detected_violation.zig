const Route = @import("route.zig").Route;

/// Violation detail for an internet gateway route with an inactive state in the
/// customer subnet route table or Network Firewall subnet route table.
pub const NetworkFirewallBlackHoleRouteDetectedViolation = struct {
    /// Information about the route table ID.
    route_table_id: ?[]const u8,

    /// Information about the route or routes that are in violation.
    violating_routes: ?[]const Route,

    /// The subnet that has an inactive state.
    violation_target: ?[]const u8,

    /// Information about the VPC ID.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .route_table_id = "RouteTableId",
        .violating_routes = "ViolatingRoutes",
        .violation_target = "ViolationTarget",
        .vpc_id = "VpcId",
    };
};
