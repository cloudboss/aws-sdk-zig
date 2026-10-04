const NatGatewayAttachmentStatus = @import("nat_gateway_attachment_status.zig").NatGatewayAttachmentStatus;

/// The definition and status of the attachment between a proxy mode firewall
/// and a NAT gateway that proxies its traffic.
pub const NatGatewayAttachment = struct {
    /// The DNS name that resolves to the firewall's proxy for traffic sent through
    /// this NAT gateway attachment.
    dns_name: ?[]const u8 = null,

    /// A unique identifier for the NAT gateway to use with proxy resources.
    nat_gateway_id: []const u8,

    /// The current status of the NAT gateway attachment.
    ///
    /// When this value is `READY`, the attachment is available to proxy traffic.
    /// Otherwise, this value reflects its state, for example `CREATING` or
    /// `DELETING`.
    status: NatGatewayAttachmentStatus,

    /// If Network Firewall encounters an issue with the NAT gateway attachment, it
    /// populates this with an explanation of the problem.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .dns_name = "DnsName",
        .nat_gateway_id = "NatGatewayId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
