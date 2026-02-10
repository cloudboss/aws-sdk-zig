const Tag = @import("tag.zig").Tag;

/// Describes an association between a local gateway route table and a virtual
/// interface group.
pub const LocalGatewayRouteTableVirtualInterfaceGroupAssociation = struct {
    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the local gateway route table for the
    /// virtual interface group.
    local_gateway_route_table_arn: ?[]const u8,

    /// The ID of the local gateway route table.
    local_gateway_route_table_id: ?[]const u8,

    /// The ID of the association.
    local_gateway_route_table_virtual_interface_group_association_id: ?[]const u8,

    /// The ID of the virtual interface group.
    local_gateway_virtual_interface_group_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the local gateway
    /// virtual interface group association.
    owner_id: ?[]const u8,

    /// The state of the association.
    state: ?[]const u8,

    /// The tags assigned to the association.
    tags: ?[]const Tag,
};
