/// A notification from the client that it is disconnecting from Amazon Lex V2.
/// Sending a `DisconnectionEvent` event is optional, but can
/// help identify a conversation in logs.
pub const DisconnectionEvent = struct {
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
