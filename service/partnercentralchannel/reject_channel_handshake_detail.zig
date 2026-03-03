const HandshakeStatus = @import("handshake_status.zig").HandshakeStatus;

/// Contains details about a rejected channel handshake.
pub const RejectChannelHandshakeDetail = struct {
    /// The Amazon Resource Name (ARN) of the rejected handshake.
    arn: ?[]const u8 = null,

    /// The unique identifier of the rejected handshake.
    id: ?[]const u8 = null,

    /// The current status of the rejected handshake.
    status: ?HandshakeStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .status = "status",
    };
};
