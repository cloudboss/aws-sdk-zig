/// Contains details about a newly created channel handshake.
pub const CreateChannelHandshakeDetail = struct {
    /// The Amazon Resource Name (ARN) of the created handshake.
    arn: ?[]const u8 = null,

    /// The unique identifier of the created handshake.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
    };
};
