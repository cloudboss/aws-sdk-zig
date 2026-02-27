const HandshakeStatus = @import("handshake_status.zig").HandshakeStatus;

/// Contains details about a canceled channel handshake.
pub const CancelChannelHandshakeDetail = struct {
    /// The Amazon Resource Name (ARN) of the canceled handshake.
    arn: ?[]const u8,

    /// The unique identifier of the canceled handshake.
    id: ?[]const u8,

    /// The current status of the canceled handshake.
    status: ?HandshakeStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .status = "status",
    };
};
