/// Details about suggested message data.
pub const SuggestedMessageDataDetails = struct {
    /// The text content of the suggested message.
    message_text: []const u8,

    pub const json_field_names = .{
        .message_text = "messageText",
    };
};
