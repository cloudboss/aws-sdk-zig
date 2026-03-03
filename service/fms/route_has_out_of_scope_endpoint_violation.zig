const Route = @import("route.zig").Route;

/// Contains details about the route endpoint that violates the policy scope.
pub const RouteHasOutOfScopeEndpointViolation = struct {
    /// The route table associated with the current firewall subnet.
    current_firewall_subnet_route_table: ?[]const u8 = null,

    /// The current route table associated with the Internet Gateway.
    current_internet_gateway_route_table: ?[]const u8 = null,

    /// The ID of the firewall subnet.
    firewall_subnet_id: ?[]const u8 = null,

    /// The list of firewall subnet routes.
    firewall_subnet_routes: ?[]const Route = null,

    /// The ID of the Internet Gateway.
    internet_gateway_id: ?[]const u8 = null,

    /// The routes in the route table associated with the Internet Gateway.
    internet_gateway_routes: ?[]const Route = null,

    /// The ID of the route table.
    route_table_id: ?[]const u8 = null,

    /// The subnet's Availability Zone.
    subnet_availability_zone: ?[]const u8 = null,

    /// The ID of the subnet's Availability Zone.
    subnet_availability_zone_id: ?[]const u8 = null,

    /// The ID of the subnet associated with the route that violates the policy
    /// scope.
    subnet_id: ?[]const u8 = null,

    /// The list of routes that violate the route table.
    violating_routes: ?[]const Route = null,

    /// The VPC ID of the route that violates the policy scope.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_firewall_subnet_route_table = "CurrentFirewallSubnetRouteTable",
        .current_internet_gateway_route_table = "CurrentInternetGatewayRouteTable",
        .firewall_subnet_id = "FirewallSubnetId",
        .firewall_subnet_routes = "FirewallSubnetRoutes",
        .internet_gateway_id = "InternetGatewayId",
        .internet_gateway_routes = "InternetGatewayRoutes",
        .route_table_id = "RouteTableId",
        .subnet_availability_zone = "SubnetAvailabilityZone",
        .subnet_availability_zone_id = "SubnetAvailabilityZoneId",
        .subnet_id = "SubnetId",
        .violating_routes = "ViolatingRoutes",
        .vpc_id = "VpcId",
    };
};
