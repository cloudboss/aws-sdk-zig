const Route = @import("route.zig").Route;
const ExpectedRoute = @import("expected_route.zig").ExpectedRoute;

/// Violation detail for the improperly configured subnet route. It's possible
/// there is a missing route table route,
/// or a configuration that causes traffic to cross an Availability Zone
/// boundary.
pub const NetworkFirewallInvalidRouteConfigurationViolation = struct {
    /// The actual firewall endpoint.
    actual_firewall_endpoint: ?[]const u8 = null,

    /// The actual subnet ID for the firewall.
    actual_firewall_subnet_id: ?[]const u8 = null,

    /// The actual firewall subnet routes that are expected.
    actual_firewall_subnet_routes: ?[]const Route = null,

    /// The actual internet gateway routes.
    actual_internet_gateway_routes: ?[]const Route = null,

    /// The subnets that are affected.
    affected_subnets: ?[]const []const u8 = null,

    /// The subnet route table for the current firewall.
    current_firewall_subnet_route_table: ?[]const u8 = null,

    /// The route table for the current internet gateway.
    current_internet_gateway_route_table: ?[]const u8 = null,

    /// The firewall endpoint that's expected.
    expected_firewall_endpoint: ?[]const u8 = null,

    /// The expected subnet ID for the firewall.
    expected_firewall_subnet_id: ?[]const u8 = null,

    /// The firewall subnet routes that are expected.
    expected_firewall_subnet_routes: ?[]const ExpectedRoute = null,

    /// The expected routes for the internet gateway.
    expected_internet_gateway_routes: ?[]const ExpectedRoute = null,

    /// The internet gateway ID.
    internet_gateway_id: ?[]const u8 = null,

    /// Information about whether the route table is used in another Availability
    /// Zone.
    is_route_table_used_in_different_az: bool = false,

    /// The route table ID.
    route_table_id: ?[]const u8 = null,

    /// The route that's in violation.
    violating_route: ?Route = null,

    /// Information about the VPC ID.
    vpc_id: ?[]const u8 = null,

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
