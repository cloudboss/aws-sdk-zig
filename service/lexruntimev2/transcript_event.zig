/// Event sent from Amazon Lex V2 to your client application that contains a
/// transcript of voice audio.
pub const TranscriptEvent = struct {
    /// A unique identifier of the event sent by Amazon Lex V2. The identifier is in
    /// the form `RESPONSE-N`, where N is a number starting with one
    /// and incremented for each event sent by Amazon Lex V2 in the current
    /// session.
    event_id: ?[]const u8 = null,

    /// The transcript of the voice audio from the user.
    transcript: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_id = "eventId",
        .transcript = "transcript",
    };
};
