/// Specifies configuration that restricts speech detection to the
/// primary (loudest) speaker during streaming audio conversations, so that
/// speech from background speakers does not start a turn, interrupt the
/// bot, or reach speech recognition.
pub const SpeakerDiarizationSettings = struct {
    /// Specifies whether speaker diarization is enabled for the bot locale.
    /// Set to `true` to have Amazon Lex treat speech from speakers other
    /// than the primary speaker as non-speech. Set to `false` to
    /// disable speaker diarization and rely on voice activity detection
    /// alone.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
