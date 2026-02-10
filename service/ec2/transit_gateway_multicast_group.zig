const MembershipType = @import("membership_type.zig").MembershipType;
const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;

/// Describes the transit gateway multicast group resources.
pub const TransitGatewayMulticastGroup = struct {
    /// The IP address assigned to the transit gateway multicast group.
    group_ip_address: ?[]const u8,

    /// Indicates that the resource is a transit gateway multicast group member.
    group_member: ?bool,

    /// Indicates that the resource is a transit gateway multicast group member.
    group_source: ?bool,

    /// The member type (for example, `static`).
    member_type: ?MembershipType,

    /// The ID of the transit gateway attachment.
    network_interface_id: ?[]const u8,

    /// The ID of the resource.
    resource_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the transit gateway
    /// multicast domain group resource.
    resource_owner_id: ?[]const u8,

    /// The type of resource, for example a VPC attachment.
    resource_type: ?TransitGatewayAttachmentResourceType,

    /// The source type.
    source_type: ?MembershipType,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,

    /// The ID of the transit gateway attachment.
    transit_gateway_attachment_id: ?[]const u8,
};
