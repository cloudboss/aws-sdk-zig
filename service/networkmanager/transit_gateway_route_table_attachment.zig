const Attachment = @import("attachment.zig").Attachment;

/// Describes a transit gateway route table attachment.
pub const TransitGatewayRouteTableAttachment = struct {
    attachment: ?Attachment = null,

    /// The ID of the peering attachment.
    peering_id: ?[]const u8 = null,

    /// The ARN of the transit gateway attachment route table. For example,
    /// `"TransitGatewayRouteTableArn":
    /// "arn:aws:ec2:us-west-2:123456789012:transit-gateway-route-table/tgw-rtb-9876543210123456"`.
    transit_gateway_route_table_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment = "Attachment",
        .peering_id = "PeeringId",
        .transit_gateway_route_table_arn = "TransitGatewayRouteTableArn",
    };
};
