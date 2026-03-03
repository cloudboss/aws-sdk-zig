const PeeringTgwInfo = @import("peering_tgw_info.zig").PeeringTgwInfo;
const TransitGatewayPeeringAttachmentOptions = @import("transit_gateway_peering_attachment_options.zig").TransitGatewayPeeringAttachmentOptions;
const TransitGatewayAttachmentState = @import("transit_gateway_attachment_state.zig").TransitGatewayAttachmentState;
const PeeringAttachmentStatus = @import("peering_attachment_status.zig").PeeringAttachmentStatus;
const Tag = @import("tag.zig").Tag;

/// Describes the transit gateway peering attachment.
pub const TransitGatewayPeeringAttachment = struct {
    /// Information about the accepter transit gateway.
    accepter_tgw_info: ?PeeringTgwInfo = null,

    /// The ID of the accepter transit gateway attachment.
    accepter_transit_gateway_attachment_id: ?[]const u8 = null,

    /// The time the transit gateway peering attachment was created.
    creation_time: ?i64 = null,

    /// Details about the transit gateway peering attachment.
    options: ?TransitGatewayPeeringAttachmentOptions = null,

    /// Information about the requester transit gateway.
    requester_tgw_info: ?PeeringTgwInfo = null,

    /// The state of the transit gateway peering attachment. Note that the
    /// `initiating` state has been deprecated.
    state: ?TransitGatewayAttachmentState = null,

    /// The status of the transit gateway peering attachment.
    status: ?PeeringAttachmentStatus = null,

    /// The tags for the transit gateway peering attachment.
    tags: ?[]const Tag = null,

    /// The ID of the transit gateway peering attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,
};
