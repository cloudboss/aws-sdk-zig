const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;

/// Describes a route attachment.
pub const TransitGatewayRouteAttachment = struct {
    /// The ID of the resource.
    resource_id: ?[]const u8,

    /// The resource type. Note that the `tgw-peering` resource type has been
    /// deprecated.
    resource_type: ?TransitGatewayAttachmentResourceType,

    /// The ID of the attachment.
    transit_gateway_attachment_id: ?[]const u8,
};
