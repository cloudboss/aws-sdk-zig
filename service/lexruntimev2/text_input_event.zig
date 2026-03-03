/// The event sent from your client application to Amazon Lex V2 with text input
/// from the user.
pub const TextInputEvent = struct {
    /// A timestamp set by the client of the date and time that the event
    /// was sent to Amazon Lex V2.
    client_timestamp_millis: i64 = 0,

    /// A unique identifier that your application assigns to the event. You
    /// can use this to identify events in logs.
    event_id: ?[]const u8 = null,

    /// The text from the user. Amazon Lex V2 processes this as a complete
    /// statement.
    text: []const u8,

    pub const json_field_names = .{
        .client_timestamp_millis = "clientTimestampMillis",
        .event_id = "eventId",
        .text = "text",
    };
};
