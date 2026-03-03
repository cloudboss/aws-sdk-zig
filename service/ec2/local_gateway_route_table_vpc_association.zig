const Tag = @import("tag.zig").Tag;

/// Describes an association between a local gateway route table and a VPC.
pub const LocalGatewayRouteTableVpcAssociation = struct {
    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the local gateway route table for the
    /// association.
    local_gateway_route_table_arn: ?[]const u8 = null,

    /// The ID of the local gateway route table.
    local_gateway_route_table_id: ?[]const u8 = null,

    /// The ID of the association.
    local_gateway_route_table_vpc_association_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the local gateway route
    /// table for the association.
    owner_id: ?[]const u8 = null,

    /// The state of the association.
    state: ?[]const u8 = null,

    /// The tags assigned to the association.
    tags: ?[]const Tag = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,
};
