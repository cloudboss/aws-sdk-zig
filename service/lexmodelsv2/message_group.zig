const Message = @import("message.zig").Message;

/// Provides one or more messages that Amazon Lex should send to the
/// user.
pub const MessageGroup = struct {
    /// The primary message that Amazon Lex should send to the user.
    message: Message,

    /// Message variations to send to the user. When variations are defined,
    /// Amazon Lex chooses the primary message or one of the variations to send to
    /// the user.
    variations: ?[]const Message,

    pub const json_field_names = .{
        .message = "message",
        .variations = "variations",
    };
};
