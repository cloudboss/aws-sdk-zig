const PlaybackInterruptionReason = @import("playback_interruption_reason.zig").PlaybackInterruptionReason;

/// Event sent from Amazon Lex V2 to indicate to the client application should
/// stop playback of audio. For example, if the client is playing a prompt
/// that asks for the user's telephone number, the user might start to say
/// the phone number before the prompt is complete. Amazon Lex V2 sends this
/// event
/// to the client application to indicate that the user is responding and
/// that Amazon Lex V2 is processing their input.
pub const PlaybackInterruptionEvent = struct {
    /// The identifier of the event that contained the audio, DTMF, or text
    /// that caused the interruption.
    caused_by_event_id: ?[]const u8 = null,

    /// A unique identifier of the event sent by Amazon Lex V2. The identifier is in
    /// the form `RESPONSE-N`, where N is a number starting with one
    /// and incremented for each event sent by Amazon Lex V2 in the current
    /// session.
    event_id: ?[]const u8 = null,

    /// Indicates the type of user input that Amazon Lex V2 detected.
    event_reason: ?PlaybackInterruptionReason = null,

    pub const json_field_names = .{
        .caused_by_event_id = "causedByEventId",
        .event_id = "eventId",
        .event_reason = "eventReason",
    };
};
