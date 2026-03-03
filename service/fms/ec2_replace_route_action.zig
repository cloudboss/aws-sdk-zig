const ActionTarget = @import("action_target.zig").ActionTarget;

/// Information about the ReplaceRoute action in Amazon EC2.
pub const EC2ReplaceRouteAction = struct {
    /// A description of the ReplaceRoute action in Amazon EC2.
    description: ?[]const u8 = null,

    /// Information about the IPv4 CIDR address block used for the destination
    /// match. The value that you provide must match the CIDR of an existing route
    /// in the table.
    destination_cidr_block: ?[]const u8 = null,

    /// Information about the IPv6 CIDR address block used for the destination
    /// match. The value that you provide must match the CIDR of an existing route
    /// in the table.
    destination_ipv_6_cidr_block: ?[]const u8 = null,

    /// Information about the ID of the prefix list for the route.
    destination_prefix_list_id: ?[]const u8 = null,

    /// Information about the ID of an internet gateway or virtual private gateway.
    gateway_id: ?ActionTarget = null,

    /// Information about the ID of the route table.
    route_table_id: ActionTarget,

    pub const json_field_names = .{
        .description = "Description",
        .destination_cidr_block = "DestinationCidrBlock",
        .destination_ipv_6_cidr_block = "DestinationIpv6CidrBlock",
        .destination_prefix_list_id = "DestinationPrefixListId",
        .gateway_id = "GatewayId",
        .route_table_id = "RouteTableId",
    };
};
