/// A DTMF character sent from the client application. DTMF characters
/// are typically sent from a phone keypad to represent numbers. For
/// example, you can have Amazon Lex V2 process a credit card number input from
/// a
/// phone.
pub const DTMFInputEvent = struct {
    /// A timestamp set by the client of the date and time that the event
    /// was sent to Amazon Lex V2.
    client_timestamp_millis: i64 = 0,

    /// A unique identifier that your application assigns to the event. You
    /// can use this to identify events in logs.
    event_id: ?[]const u8,

    /// The DTMF character that the user pressed. The allowed characters are
    /// A - D, 0 - 9, # and *.
    input_character: []const u8,

    pub const json_field_names = .{
        .client_timestamp_millis = "clientTimestampMillis",
        .event_id = "eventId",
        .input_character = "inputCharacter",
    };
};
