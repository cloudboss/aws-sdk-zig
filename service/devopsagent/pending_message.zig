const Message = @import("message.zig").Message;

/// Represents a pending message in an agent execution.
pub const PendingMessage = struct {
    /// The message content.
    message: Message,

    /// The unique identifier for this pending message.
    message_id: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .message_id = "messageId",
    };
};
