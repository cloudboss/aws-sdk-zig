const Route = @import("route.zig").Route;
const ExpectedRoute = @import("expected_route.zig").ExpectedRoute;

/// Violation detail for the improperly configured subnet route. It's possible
/// there is a missing route table route,
/// or a configuration that causes traffic to cross an Availability Zone
/// boundary.
pub const NetworkFirewallInvalidRouteConfigurationViolation = struct {
    /// The actual firewall endpoint.
    actual_firewall_endpoint: ?[]const u8,

    /// The actual subnet ID for the firewall.
    actual_firewall_subnet_id: ?[]const u8,

    /// The actual firewall subnet routes that are expected.
    actual_firewall_subnet_routes: ?[]const Route,

    /// The actual internet gateway routes.
    actual_internet_gateway_routes: ?[]const Route,

    /// The subnets that are affected.
    affected_subnets: ?[]const []const u8,

    /// The subnet route table for the current firewall.
    current_firewall_subnet_route_table: ?[]const u8,

    /// The route table for the current internet gateway.
    current_internet_gateway_route_table: ?[]const u8,

    /// The firewall endpoint that's expected.
    expected_firewall_endpoint: ?[]const u8,

    /// The expected subnet ID for the firewall.
    expected_firewall_subnet_id: ?[]const u8,

    /// The firewall subnet routes that are expected.
    expected_firewall_subnet_routes: ?[]const ExpectedRoute,

    /// The expected routes for the internet gateway.
    expected_internet_gateway_routes: ?[]const ExpectedRoute,

    /// The internet gateway ID.
    internet_gateway_id: ?[]const u8,

    /// Information about whether the route table is used in another Availability
    /// Zone.
    is_route_table_used_in_different_az: bool = false,

    /// The route table ID.
    route_table_id: ?[]const u8,

    /// The route that's in violation.
    violating_route: ?Route,

    /// Information about the VPC ID.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .actual_firewall_endpoint = "ActualFirewallEndpoint",
        .actual_firewall_subnet_id = "ActualFirewallSubnetId",
        .actual_firewall_subnet_routes = "ActualFirewallSubnetRoutes",
        .actual_internet_gateway_routes = "ActualInternetGatewayRoutes",
        .affected_subnets = "AffectedSubnets",
        .current_firewall_subnet_route_table = "CurrentFirewallSubnetRouteTable",
        .current_internet_gateway_route_table = "CurrentInternetGatewayRouteTable",
        .expected_firewall_endpoint = "ExpectedFirewallEndpoint",
        .expected_firewall_subnet_id = "ExpectedFirewallSubnetId",
        .expected_firewall_subnet_routes = "ExpectedFirewallSubnetRoutes",
        .expected_internet_gateway_routes = "ExpectedInternetGatewayRoutes",
        .internet_gateway_id = "InternetGatewayId",
        .is_route_table_used_in_different_az = "IsRouteTableUsedInDifferentAZ",
        .route_table_id = "RouteTableId",
        .violating_route = "ViolatingRoute",
        .vpc_id = "VpcId",
    };
};
