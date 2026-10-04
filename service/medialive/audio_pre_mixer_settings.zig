const AudioNormalizationSettings = @import("audio_normalization_settings.zig").AudioNormalizationSettings;
const RemixSettings = @import("remix_settings.zig").RemixSettings;

/// Audio pre-mixer settings for normalizing audio before interleaving.
/// These settings can be applied to individual PIDs or tracks before they are
/// combined.
pub const AudioPreMixerSettings = struct {
    /// Audio normalization settings for loudness control.
    /// When specified, audio loudness will be normalized according to the chosen
    /// algorithm.
    audio_normalization_settings: ?AudioNormalizationSettings = null,

    /// Number of audio channels.
    /// If specified, the audio will be remixed to match this channel count.
    /// Ignored if remixSettings is specified.
    channels: ?i32 = null,

    /// Gain adjustment in dB to apply.
    /// Range: -60 to +60 dB
    gain_db: ?f64 = null,

    /// Settings that control how input audio channels are remixed.
    /// When specified, allows fine-grained control over channel mapping and gain
    /// levels.
    /// Takes precedence over the 'channels' setting.
    remix_settings: ?RemixSettings = null,

    pub const json_field_names = .{
        .audio_normalization_settings = "AudioNormalizationSettings",
        .channels = "Channels",
        .gain_db = "GainDb",
        .remix_settings = "RemixSettings",
    };
};
