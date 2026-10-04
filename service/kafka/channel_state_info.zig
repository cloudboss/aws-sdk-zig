/// Additional context for the current channel state, populated when the channel
/// is in FAILED.
pub const ChannelStateInfo = struct {
    /// A short, machine-readable code identifying the failure cause.
    code: ?[]const u8 = null,

    /// A human-readable message describing the failure.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
