/// Represents a chunk of audio sent from the client application to
/// Amazon Lex V2. The audio is all or part of an utterance from the user.
///
/// Amazon Lex V2 accumulates audio chunks until it recognizes a natural pause
/// in speech before processing the input.
pub const AudioInputEvent = struct {
    /// An encoded stream of audio.
    audio_chunk: ?[]const u8,

    /// A timestamp set by the client of the date and time that the event
    /// was sent to Amazon Lex V2.
    client_timestamp_millis: i64 = 0,

    /// The encoding used for the audio chunk. You must use 8 KHz PCM 16-bit
    /// mono-channel little-endian format. The value of the field should
    /// be:
    ///
    /// `audio/lpcm; sample-rate=8000; sample-size-bits=16;
    /// channel-count=1; is-big-endian=false`
    content_type: []const u8,

    /// A unique identifier that your application assigns to the event. You
    /// can use this to identify events in logs.
    event_id: ?[]const u8,

    pub const json_field_names = .{
        .audio_chunk = "audioChunk",
        .client_timestamp_millis = "clientTimestampMillis",
        .content_type = "contentType",
        .event_id = "eventId",
    };
};
