const LocalGatewayRouteState = @import("local_gateway_route_state.zig").LocalGatewayRouteState;
const LocalGatewayRouteType = @import("local_gateway_route_type.zig").LocalGatewayRouteType;

/// Describes a route for a local gateway route table.
pub const LocalGatewayRoute = struct {
    /// The ID of the customer-owned address pool.
    coip_pool_id: ?[]const u8,

    /// The CIDR block used for destination matches.
    destination_cidr_block: ?[]const u8,

    /// The ID of the prefix list.
    destination_prefix_list_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the local gateway route table.
    local_gateway_route_table_arn: ?[]const u8,

    /// The ID of the local gateway route table.
    local_gateway_route_table_id: ?[]const u8,

    /// The ID of the virtual interface group.
    local_gateway_virtual_interface_group_id: ?[]const u8,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the local gateway route.
    owner_id: ?[]const u8,

    /// The state of the route.
    state: ?LocalGatewayRouteState,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,

    /// The route type.
    @"type": ?LocalGatewayRouteType,
};
