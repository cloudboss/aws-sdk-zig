const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const TransitGatewayAssociationState = @import("transit_gateway_association_state.zig").TransitGatewayAssociationState;

/// Describes an association between a resource attachment and a transit gateway
/// route table.
pub const TransitGatewayAssociation = struct {
    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The resource type. Note that the `tgw-peering` resource type has been
    /// deprecated.
    resource_type: ?TransitGatewayAttachmentResourceType = null,

    /// The state of the association.
    state: ?TransitGatewayAssociationState = null,

    /// The ID of the attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,

    /// The ID of the transit gateway route table.
    transit_gateway_route_table_id: ?[]const u8 = null,
};
