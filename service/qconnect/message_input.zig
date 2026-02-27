const MessageData = @import("message_data.zig").MessageData;

/// The message input.
pub const MessageInput = struct {
    /// The message input value.
    value: MessageData,

    pub const json_field_names = .{
        .value = "value",
    };
};
