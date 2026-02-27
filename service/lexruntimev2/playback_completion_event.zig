/// Event sent from the client application to Amazon Lex V2 to indicate that
/// playback of audio is complete and that Amazon Lex V2 should start processing
/// the user's input.
pub const PlaybackCompletionEvent = struct {
    /// A timestamp set by the client of the date and time that the event
    /// was sent to Amazon Lex V2.
    client_timestamp_millis: i64 = 0,

    /// A unique identifier that your application assigns to the event. You
    /// can use this to identify events in logs.
    event_id: ?[]const u8,

    pub const json_field_names = .{
        .client_timestamp_millis = "clientTimestampMillis",
        .event_id = "eventId",
    };
};
