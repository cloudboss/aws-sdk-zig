const TransitGatewayAttachmentStatusType = @import("transit_gateway_attachment_status_type.zig").TransitGatewayAttachmentStatusType;

/// Describes a Transit Gateway attachment for a Client VPN endpoint.
pub const TransitGatewayClientVpnAttachment = struct {
    /// The ID of the Client VPN endpoint.
    client_vpn_endpoint_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the Client VPN endpoint.
    client_vpn_owner_id: ?[]const u8 = null,

    /// The date and time the Transit Gateway attachment was created.
    creation_time: ?[]const u8 = null,

    /// The state of the Transit Gateway attachment.
    state: ?TransitGatewayAttachmentStatusType = null,

    /// The ID of the Transit Gateway attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,

    /// The ID of the Transit Gateway.
    transit_gateway_id: ?[]const u8 = null,
};
