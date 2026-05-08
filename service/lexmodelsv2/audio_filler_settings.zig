const AudioFillerType = @import("audio_filler_type.zig").AudioFillerType;

/// Configuration that plays background filler audio during speech-to-speech
/// interactions to mask processing delays and improve the perceived
/// responsiveness of the bot.
///
/// Audio filler requires `unifiedSpeechSettings` (speech-to-speech)
/// to be enabled on the bot locale when `enabled` is
/// `true`.
pub const AudioFillerSettings = struct {
    /// The identifier of the audio filler to play while Amazon Lex processes the
    /// user's input. This field is required when `enabled` is
    /// `true`.
    audio_type: ?AudioFillerType = null,

    /// Specifies whether audio filler playback is enabled for the bot locale.
    /// Set to `true` to play filler audio while Amazon Lex processes a
    /// user utterance. Set to `false` to disable filler audio.
    enabled: bool = false,

    /// The minimum time, in milliseconds, that audio filler plays once it
    /// has started, even if the bot response becomes ready sooner. Valid range
    /// is `1000` to `5000` milliseconds. If not
    /// specified, Amazon Lex uses a default of `3000`
    /// milliseconds.
    minimum_play_duration_in_milliseconds: ?i32 = null,

    /// The silent delay, in milliseconds, inserted between the end of audio
    /// filler playback and the start of the bot's response. Valid range is
    /// `200` to `1000` milliseconds. If not specified,
    /// Amazon Lex uses a default of `500` milliseconds.
    response_delivery_delay_in_milliseconds: ?i32 = null,

    /// The time, in milliseconds, to wait after the end of the user's
    /// utterance before starting audio filler playback. Valid range is
    /// `500` to `5000` milliseconds. If not specified,
    /// Amazon Lex uses a default of `2500` milliseconds.
    start_delay_in_milliseconds: ?i32 = null,

    pub const json_field_names = .{
        .audio_type = "audioType",
        .enabled = "enabled",
        .minimum_play_duration_in_milliseconds = "minimumPlayDurationInMilliseconds",
        .response_delivery_delay_in_milliseconds = "responseDeliveryDelayInMilliseconds",
        .start_delay_in_milliseconds = "startDelayInMilliseconds",
    };
};
