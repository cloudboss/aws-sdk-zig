const Message = @import("message.zig").Message;

/// A collection of messages that convey information to the user. At
/// runtime, Amazon Lex selects the message to convey.
pub const Statement = struct {
    /// A collection of message objects.
    messages: []const Message,

    /// At runtime, if the client is using the
    /// [PostText](http://docs.aws.amazon.com/lex/latest/dg/API_runtime_PostText.html) API, Amazon Lex includes the response card in the response.
    /// It substitutes all of the session attributes and slot values for
    /// placeholders in the response card.
    response_card: ?[]const u8,

    pub const json_field_names = .{
        .messages = "messages",
        .response_card = "responseCard",
    };
};
