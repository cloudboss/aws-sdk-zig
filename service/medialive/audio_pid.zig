const AudioDolbyEDecode = @import("audio_dolby_e_decode.zig").AudioDolbyEDecode;
const AudioPreMixerSettings = @import("audio_pre_mixer_settings.zig").AudioPreMixerSettings;

/// Represents a single PID value for audio selection with optional pre-mixer
/// settings
pub const AudioPid = struct {
    /// Configure decoding options for Dolby E streams - these should be Dolby E
    /// frames carried in PCM streams tagged with SMPTE-337.
    /// When using the 'pids' array, if this field is not specified and Dolby E
    /// content is present,
    /// the decoder will extract the specified program. To maintain legacy behavior
    /// (allPrograms),
    /// explicitly set programSelection to "allChannels".
    dolby_e_decode: ?AudioDolbyEDecode = null,

    /// PID value from within a source.
    pid: i32,

    /// Optional audio pre-mixer settings for this PID.
    /// When specified, allows per-PID audio processing including channel remixing,
    /// gain adjustment, and loudness normalization before interleaving.
    premix_settings: ?AudioPreMixerSettings = null,

    pub const json_field_names = .{
        .dolby_e_decode = "DolbyEDecode",
        .pid = "Pid",
        .premix_settings = "PremixSettings",
    };
};
