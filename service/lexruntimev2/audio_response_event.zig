/// An event sent from Amazon Lex V2 to your client application containing audio
/// to play to the user.
pub const AudioResponseEvent = struct {
    /// A chunk of the audio to play.
    audio_chunk: ?[]const u8,

    /// The encoding of the audio chunk. This is the same as the encoding
    /// configure in the `contentType` field of the
    /// `ConfigurationEvent`.
    content_type: ?[]const u8,

    /// A unique identifier of the event sent by Amazon Lex V2. The identifier is in
    /// the form `RESPONSE-N`, where N is a number starting with one
    /// and incremented for each event sent by Amazon Lex V2 in the current
    /// session.
    event_id: ?[]const u8,

    pub const json_field_names = .{
        .audio_chunk = "audioChunk",
        .content_type = "contentType",
        .event_id = "eventId",
    };
};
