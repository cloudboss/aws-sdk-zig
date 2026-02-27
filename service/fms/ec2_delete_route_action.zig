const ActionTarget = @import("action_target.zig").ActionTarget;

/// Information about the DeleteRoute action in Amazon EC2.
pub const EC2DeleteRouteAction = struct {
    /// A description of the DeleteRoute action.
    description: ?[]const u8,

    /// Information about the IPv4 CIDR range for the route. The value you specify
    /// must match the CIDR for the route exactly.
    destination_cidr_block: ?[]const u8,

    /// Information about the IPv6 CIDR range for the route. The value you specify
    /// must match the CIDR for the route exactly.
    destination_ipv_6_cidr_block: ?[]const u8,

    /// Information about the ID of the prefix list for the route.
    destination_prefix_list_id: ?[]const u8,

    /// Information about the ID of the route table.
    route_table_id: ActionTarget,

    pub const json_field_names = .{
        .description = "Description",
        .destination_cidr_block = "DestinationCidrBlock",
        .destination_ipv_6_cidr_block = "DestinationIpv6CidrBlock",
        .destination_prefix_list_id = "DestinationPrefixListId",
        .route_table_id = "RouteTableId",
    };
};
