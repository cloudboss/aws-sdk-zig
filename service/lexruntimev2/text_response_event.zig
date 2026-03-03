const Message = @import("message.zig").Message;

/// The event sent from Amazon Lex V2 to your application with text to present
/// to the user.
pub const TextResponseEvent = struct {
    /// A unique identifier of the event sent by Amazon Lex V2. The identifier is in
    /// the form `RESPONSE-N`, where N is a number starting with one
    /// and incremented for each event sent by Amazon Lex V2 in the current
    /// session.
    event_id: ?[]const u8 = null,

    /// A list of messages to send to the user. Messages are ordered based
    /// on the order that you returned the messages from your Lambda function
    /// or the order that the messages are defined in the bot.
    messages: ?[]const Message = null,

    pub const json_field_names = .{
        .event_id = "eventId",
        .messages = "messages",
    };
};
