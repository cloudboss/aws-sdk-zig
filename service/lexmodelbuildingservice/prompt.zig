const Message = @import("message.zig").Message;

/// Obtains information from the user. To define a prompt, provide one
/// or more messages and specify the number of attempts to get information
/// from the user. If you provide more than one message, Amazon Lex chooses one
/// of
/// the messages to use to prompt the user. For more information, see
/// how-it-works.
pub const Prompt = struct {
    /// The number of times to prompt the user for information.
    max_attempts: i32,

    /// An array of objects, each of which provides a message string and
    /// its type. You can specify the message string in plain text or in Speech
    /// Synthesis Markup Language (SSML).
    messages: []const Message,

    /// A response card. Amazon Lex uses this prompt at runtime, in the
    /// `PostText` API response. It substitutes session attributes
    /// and slot values for placeholders in the response card. For more
    /// information, see ex-resp-card.
    response_card: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_attempts = "maxAttempts",
        .messages = "messages",
        .response_card = "responseCard",
    };
};
