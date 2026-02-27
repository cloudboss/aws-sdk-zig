/// Event that Amazon Lex V2 sends to indicate that the stream is still open
/// between the client application and Amazon Lex V2
pub const HeartbeatEvent = struct {
    /// A unique identifier of the event sent by Amazon Lex V2. The identifier is in
    /// the form `RESPONSE-N`, where N is a number starting with one
    /// and incremented for each event sent by Amazon Lex V2 in the current
    /// session.
    event_id: ?[]const u8,

    pub const json_field_names = .{
        .event_id = "eventId",
    };
};
