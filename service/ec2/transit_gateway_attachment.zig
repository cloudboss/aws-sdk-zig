const TransitGatewayAttachmentAssociation = @import("transit_gateway_attachment_association.zig").TransitGatewayAttachmentAssociation;
const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const TransitGatewayAttachmentState = @import("transit_gateway_attachment_state.zig").TransitGatewayAttachmentState;
const Tag = @import("tag.zig").Tag;

/// Describes an attachment between a resource and a transit gateway.
pub const TransitGatewayAttachment = struct {
    /// The association.
    association: ?TransitGatewayAttachmentAssociation,

    /// The creation time.
    creation_time: ?i64,

    /// The ID of the resource.
    resource_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the resource.
    resource_owner_id: ?[]const u8,

    /// The resource type. Note that the `tgw-peering` resource type has been
    /// deprecated.
    resource_type: ?TransitGatewayAttachmentResourceType,

    /// The attachment state. Note that the `initiating` state has been deprecated.
    state: ?TransitGatewayAttachmentState,

    /// The tags for the attachment.
    tags: ?[]const Tag,

    /// The ID of the attachment.
    transit_gateway_attachment_id: ?[]const u8,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the transit gateway.
    transit_gateway_owner_id: ?[]const u8,
};
