/// The trigger configuration based on a message.
pub const MessageBasedTriggerInput = struct {
    /// The number of messages that trigger memory processing.
    message_count: i32 = 6,

    pub const json_field_names = .{
        .message_count = "messageCount",
    };
};
