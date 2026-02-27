/// Defines an ASCII text message to send to the user.
pub const PlainTextMessage = struct {
    /// The message to send to the user.
    value: []const u8,

    pub const json_field_names = .{
        .value = "value",
    };
};
