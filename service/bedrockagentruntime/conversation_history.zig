const Message = @import("message.zig").Message;

/// A conversation history.
pub const ConversationHistory = struct {
    /// The conversation's messages.
    messages: ?[]const Message = null,

    pub const json_field_names = .{
        .messages = "messages",
    };
};
