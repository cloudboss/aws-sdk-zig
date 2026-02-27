const Attachment = @import("attachment.zig").Attachment;

/// Describes a Direct Connect gateway attachment.
pub const DirectConnectGatewayAttachment = struct {
    attachment: ?Attachment,

    /// The Direct Connect gateway attachment ARN.
    direct_connect_gateway_arn: ?[]const u8,

    pub const json_field_names = .{
        .attachment = "Attachment",
        .direct_connect_gateway_arn = "DirectConnectGatewayArn",
    };
};
