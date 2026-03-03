/// Placeholder documentation for AudioSilenceFailoverSettings
pub const AudioSilenceFailoverSettings = struct {
    /// The name of the audio selector in the input that MediaLive should monitor to
    /// detect silence. Select your most important rendition. If you didn't create
    /// an audio selector in this input, leave blank.
    audio_selector_name: []const u8,

    /// The amount of time (in milliseconds) that the active input must be silent
    /// before automatic input failover occurs. Silence is defined as audio loss or
    /// audio quieter than -50 dBFS.
    audio_silence_threshold_msec: ?i32 = null,

    pub const json_field_names = .{
        .audio_selector_name = "AudioSelectorName",
        .audio_silence_threshold_msec = "AudioSilenceThresholdMsec",
    };
};
