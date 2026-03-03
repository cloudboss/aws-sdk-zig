const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const SubnetAssociation = @import("subnet_association.zig").SubnetAssociation;

/// Describes the multicast domain associations.
pub const TransitGatewayMulticastDomainAssociations = struct {
    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the resource.
    resource_owner_id: ?[]const u8 = null,

    /// The type of resource, for example a VPC attachment.
    resource_type: ?TransitGatewayAttachmentResourceType = null,

    /// The subnets associated with the multicast domain.
    subnets: ?[]const SubnetAssociation = null,

    /// The ID of the transit gateway attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,

    /// The ID of the transit gateway multicast domain.
    transit_gateway_multicast_domain_id: ?[]const u8 = null,
};
