const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;

/// Describes the traffic matching criteria for a transit gateway metering
/// policy rule.
pub const TransitGatewayMeteringPolicyRule = struct {
    /// The destination CIDR block for the rule.
    destination_cidr_block: ?[]const u8,

    /// The destination port range for the rule.
    destination_port_range: ?[]const u8,

    /// The ID of the destination transit gateway attachment.
    destination_transit_gateway_attachment_id: ?[]const u8,

    /// The type of the destination transit gateway attachment. Note that the
    /// `tgw-peering` resource type has been deprecated. To configure metering
    /// policies for Connect, use the transport attachment type.
    destination_transit_gateway_attachment_type: ?TransitGatewayAttachmentResourceType,

    /// The protocol for the rule (1, 6, 17, etc.).
    protocol: ?[]const u8,

    /// The source CIDR block for the rule.
    source_cidr_block: ?[]const u8,

    /// The source port range for the rule.
    source_port_range: ?[]const u8,

    /// The ID of the source transit gateway attachment.
    source_transit_gateway_attachment_id: ?[]const u8,

    /// The type of the source transit gateway attachment. Note that the
    /// `tgw-peering` resource type has been deprecated. To configure metering
    /// policies for Connect, use the transport attachment type.
    source_transit_gateway_attachment_type: ?TransitGatewayAttachmentResourceType,
};
