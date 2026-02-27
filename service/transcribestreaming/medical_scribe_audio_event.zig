/// A wrapper for your audio chunks
///
/// For more information, see [Event stream
/// encoding](https://docs.aws.amazon.com/transcribe/latest/dg/event-stream.html).
pub const MedicalScribeAudioEvent = struct {
    /// An audio blob containing the next segment of audio from your application,
    /// with a maximum duration of 1 second.
    /// The maximum size in bytes varies based on audio properties.
    ///
    /// Find recommended size in [Transcribing streaming best
    /// practices](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html#best-practices).
    ///
    /// Size calculation: `Duration (s) * Sample Rate (Hz) * Number of Channels * 2
    /// (Bytes per Sample)`
    ///
    /// For example, a 1-second chunk of 16 kHz, 2-channel, 16-bit audio would be
    /// `1 * 16000 * 2 * 2 = 64000 bytes`.
    ///
    /// For 8 kHz, 1-channel, 16-bit audio, a 1-second chunk would be
    /// `1 * 8000 * 1 * 2 = 16000 bytes`.
    audio_chunk: []const u8,

    pub const json_field_names = .{
        .audio_chunk = "AudioChunk",
    };
};
