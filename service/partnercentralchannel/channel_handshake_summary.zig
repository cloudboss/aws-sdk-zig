const HandshakeDetail = @import("handshake_detail.zig").HandshakeDetail;
const HandshakeType = @import("handshake_type.zig").HandshakeType;
const HandshakeStatus = @import("handshake_status.zig").HandshakeStatus;

/// Summary information about a channel handshake.
pub const ChannelHandshakeSummary = struct {
    /// The Amazon Resource Name (ARN) of the handshake.
    arn: ?[]const u8 = null,

    /// The identifier of the resource associated with the handshake.
    associated_resource_id: ?[]const u8 = null,

    /// The catalog identifier associated with the handshake.
    catalog: ?[]const u8 = null,

    /// The timestamp when the handshake was created.
    created_at: ?i64 = null,

    /// Detailed information about the handshake.
    detail: ?HandshakeDetail = null,

    /// The type of the handshake.
    handshake_type: ?HandshakeType = null,

    /// The unique identifier of the handshake.
    id: ?[]const u8 = null,

    /// The AWS account ID of the handshake owner.
    owner_account_id: ?[]const u8 = null,

    /// The AWS account ID of the handshake receiver.
    receiver_account_id: ?[]const u8 = null,

    /// The AWS account ID of the handshake sender.
    sender_account_id: ?[]const u8 = null,

    /// The display name of the handshake sender.
    sender_display_name: ?[]const u8 = null,

    /// The current status of the handshake.
    status: ?HandshakeStatus = null,

    /// The timestamp when the handshake was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .associated_resource_id = "associatedResourceId",
        .catalog = "catalog",
        .created_at = "createdAt",
        .detail = "detail",
        .handshake_type = "handshakeType",
        .id = "id",
        .owner_account_id = "ownerAccountId",
        .receiver_account_id = "receiverAccountId",
        .sender_account_id = "senderAccountId",
        .sender_display_name = "senderDisplayName",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
