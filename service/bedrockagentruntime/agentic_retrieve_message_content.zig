/// The content of an agentic retrieval message.
pub const AgenticRetrieveMessageContent = struct {
    /// The text content of the message.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
    };
};
