const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;

/// Describes a transit gateway prefix list attachment.
pub const TransitGatewayPrefixListAttachment = struct {
    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The resource type. Note that the `tgw-peering` resource type has been
    /// deprecated.
    resource_type: ?TransitGatewayAttachmentResourceType = null,

    /// The ID of the attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,
};
