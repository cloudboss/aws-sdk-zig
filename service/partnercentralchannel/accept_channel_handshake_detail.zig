const HandshakeStatus = @import("handshake_status.zig").HandshakeStatus;

/// Contains details about an accepted channel handshake.
pub const AcceptChannelHandshakeDetail = struct {
    /// The Amazon Resource Name (ARN) of the accepted handshake.
    arn: ?[]const u8,

    /// The unique identifier of the accepted handshake.
    id: ?[]const u8,

    /// The current status of the accepted handshake.
    status: ?HandshakeStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .status = "status",
    };
};
