const TransitGatewayConnectOptions = @import("transit_gateway_connect_options.zig").TransitGatewayConnectOptions;
const TransitGatewayAttachmentState = @import("transit_gateway_attachment_state.zig").TransitGatewayAttachmentState;
const Tag = @import("tag.zig").Tag;

/// Describes a transit gateway Connect attachment.
pub const TransitGatewayConnect = struct {
    /// The creation time.
    creation_time: ?i64 = null,

    /// The Connect attachment options.
    options: ?TransitGatewayConnectOptions = null,

    /// The state of the attachment.
    state: ?TransitGatewayAttachmentState = null,

    /// The tags for the attachment.
    tags: ?[]const Tag = null,

    /// The ID of the Connect attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of the attachment from which the Connect attachment was created.
    transport_transit_gateway_attachment_id: ?[]const u8 = null,
};
