const TransitGatewayAssociationState = @import("transit_gateway_association_state.zig").TransitGatewayAssociationState;

/// Describes an association.
pub const TransitGatewayAttachmentAssociation = struct {
    /// The state of the association.
    state: ?TransitGatewayAssociationState,

    /// The ID of the route table for the transit gateway.
    transit_gateway_route_table_id: ?[]const u8,
};
