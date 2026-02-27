const Route = @import("route.zig").Route;
const ExpectedRoute = @import("expected_route.zig").ExpectedRoute;

/// Violation detail for the subnet for which internet traffic that hasn't been
/// inspected.
pub const NetworkFirewallInternetTrafficNotInspectedViolation = struct {
    /// The actual firewall subnet routes.
    actual_firewall_subnet_routes: ?[]const Route,

    /// The actual internet gateway routes.
    actual_internet_gateway_routes: ?[]const Route,

    /// Information about the subnet route table for the current firewall.
    current_firewall_subnet_route_table: ?[]const u8,

    /// The current route table for the internet gateway.
    current_internet_gateway_route_table: ?[]const u8,

    /// The expected endpoint for the current firewall.
    expected_firewall_endpoint: ?[]const u8,

    /// The firewall subnet routes that are expected.
    expected_firewall_subnet_routes: ?[]const ExpectedRoute,

    /// The internet gateway routes that are expected.
    expected_internet_gateway_routes: ?[]const ExpectedRoute,

    /// The firewall subnet ID.
    firewall_subnet_id: ?[]const u8,

    /// The internet gateway ID.
    internet_gateway_id: ?[]const u8,

    /// Information about whether the route table is used in another Availability
    /// Zone.
    is_route_table_used_in_different_az: bool = false,

    /// Information about the route table ID.
    route_table_id: ?[]const u8,

    /// The subnet Availability Zone.
    subnet_availability_zone: ?[]const u8,

    /// The subnet ID.
    subnet_id: ?[]const u8,

    /// The route or routes that are in violation.
    violating_routes: ?[]const Route,

    /// Information about the VPC ID.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .actual_firewall_subnet_routes = "ActualFirewallSubnetRoutes",
        .actual_internet_gateway_routes = "ActualInternetGatewayRoutes",
        .current_firewall_subnet_route_table = "CurrentFirewallSubnetRouteTable",
        .current_internet_gateway_route_table = "CurrentInternetGatewayRouteTable",
        .expected_firewall_endpoint = "ExpectedFirewallEndpoint",
        .expected_firewall_subnet_routes = "ExpectedFirewallSubnetRoutes",
        .expected_internet_gateway_routes = "ExpectedInternetGatewayRoutes",
        .firewall_subnet_id = "FirewallSubnetId",
        .internet_gateway_id = "InternetGatewayId",
        .is_route_table_used_in_different_az = "IsRouteTableUsedInDifferentAZ",
        .route_table_id = "RouteTableId",
        .subnet_availability_zone = "SubnetAvailabilityZone",
        .subnet_id = "SubnetId",
        .violating_routes = "ViolatingRoutes",
        .vpc_id = "VpcId",
    };
};
