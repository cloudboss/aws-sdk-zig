/// Contains information about the reasoning that the model used to return the
/// content in the content block.
pub const ReasoningTextBlock = struct {
    /// A hash of all the messages in the conversation to ensure that the content in
    /// the reasoning text block isn't tampered with. You must submit the signature
    /// in subsequent `Converse` requests, in addition to the previous messages. If
    /// the previous messages are tampered with, the response throws an error.
    signature: ?[]const u8 = null,

    /// Text describing the reasoning that the model used to return the content in
    /// the content block.
    text: []const u8,

    pub const json_field_names = .{
        .signature = "signature",
        .text = "text",
    };
};
