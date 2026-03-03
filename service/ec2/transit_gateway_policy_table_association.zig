const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const TransitGatewayAssociationState = @import("transit_gateway_association_state.zig").TransitGatewayAssociationState;

/// Describes a transit gateway policy table association.
pub const TransitGatewayPolicyTableAssociation = struct {
    /// The resource ID of the transit gateway attachment.
    resource_id: ?[]const u8 = null,

    /// The resource type for the transit gateway policy table association.
    resource_type: ?TransitGatewayAttachmentResourceType = null,

    /// The state of the transit gateway policy table association.
    state: ?TransitGatewayAssociationState = null,

    /// The ID of the transit gateway attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,

    /// The ID of the transit gateway policy table.
    transit_gateway_policy_table_id: ?[]const u8 = null,
};
