/// Information relating to readiness check status.
pub const Message = struct {
    /// The text of a readiness check message.
    message_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_text = "MessageText",
    };
};
