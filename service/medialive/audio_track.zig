const AudioPreMixerSettings = @import("audio_pre_mixer_settings.zig").AudioPreMixerSettings;

/// Represents a single audio track for selection with optional pre-mixer
/// settings
pub const AudioTrack = struct {
    /// Optional audio pre-mixer settings for this track.
    /// When specified, allows per-track audio processing including channel
    /// remixing,
    /// gain adjustment, and loudness normalization before interleaving.
    premix_settings: ?AudioPreMixerSettings = null,

    /// 1-based integer value that maps to a specific audio track
    track: i32,

    pub const json_field_names = .{
        .premix_settings = "PremixSettings",
        .track = "Track",
    };
};
