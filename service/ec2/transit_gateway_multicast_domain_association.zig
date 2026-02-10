const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const SubnetAssociation = @import("subnet_association.zig").SubnetAssociation;

/// Describes the resources associated with the transit gateway multicast
/// domain.
pub const TransitGatewayMulticastDomainAssociation = struct {
    /// The ID of the resource.
    resource_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the transit gateway
    /// multicast domain association resource.
    resource_owner_id: ?[]const u8,

    /// The type of resource, for example a VPC attachment.
    resource_type: ?TransitGatewayAttachmentResourceType,

    /// The subnet associated with the transit gateway multicast domain.
    subnet: ?SubnetAssociation,

    /// The ID of the transit gateway attachment.
    transit_gateway_attachment_id: ?[]const u8,
};
