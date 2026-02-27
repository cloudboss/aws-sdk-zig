const ActionTarget = @import("action_target.zig").ActionTarget;

/// Information about the CreateRoute action in Amazon EC2.
pub const EC2CreateRouteAction = struct {
    /// A description of CreateRoute action in Amazon EC2.
    description: ?[]const u8,

    /// Information about the IPv4 CIDR address block used for the destination
    /// match.
    destination_cidr_block: ?[]const u8,

    /// Information about the IPv6 CIDR block destination.
    destination_ipv_6_cidr_block: ?[]const u8,

    /// Information about the ID of a prefix list used for the destination match.
    destination_prefix_list_id: ?[]const u8,

    /// Information about the ID of an internet gateway or virtual private gateway
    /// attached to your VPC.
    gateway_id: ?ActionTarget,

    /// Information about the ID of the route table for the route.
    route_table_id: ActionTarget,

    /// Information about the ID of a VPC endpoint. Supported for Gateway Load
    /// Balancer endpoints only.
    vpc_endpoint_id: ?ActionTarget,

    pub const json_field_names = .{
        .description = "Description",
        .destination_cidr_block = "DestinationCidrBlock",
        .destination_ipv_6_cidr_block = "DestinationIpv6CidrBlock",
        .destination_prefix_list_id = "DestinationPrefixListId",
        .gateway_id = "GatewayId",
        .route_table_id = "RouteTableId",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};
