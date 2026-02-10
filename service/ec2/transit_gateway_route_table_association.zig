const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const TransitGatewayAssociationState = @import("transit_gateway_association_state.zig").TransitGatewayAssociationState;

/// Describes an association between a route table and a resource attachment.
pub const TransitGatewayRouteTableAssociation = struct {
    /// The ID of the resource.
    resource_id: ?[]const u8,

    /// The resource type. Note that the `tgw-peering` resource type has been
    /// deprecated.
    resource_type: ?TransitGatewayAttachmentResourceType,

    /// The state of the association.
    state: ?TransitGatewayAssociationState,

    /// The ID of the attachment.
    transit_gateway_attachment_id: ?[]const u8,
};
