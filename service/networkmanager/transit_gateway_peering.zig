const Peering = @import("peering.zig").Peering;

/// Describes a transit gateway peering attachment.
pub const TransitGatewayPeering = struct {
    /// Describes a transit gateway peer connection.
    peering: ?Peering = null,

    /// The ARN of the transit gateway.
    transit_gateway_arn: ?[]const u8 = null,

    /// The ID of the transit gateway peering attachment.
    transit_gateway_peering_attachment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .peering = "Peering",
        .transit_gateway_arn = "TransitGatewayArn",
        .transit_gateway_peering_attachment_id = "TransitGatewayPeeringAttachmentId",
    };
};
