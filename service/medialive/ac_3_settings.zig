const Ac3AttenuationControl = @import("ac_3_attenuation_control.zig").Ac3AttenuationControl;
const Ac3BitstreamMode = @import("ac_3_bitstream_mode.zig").Ac3BitstreamMode;
const Ac3CodingMode = @import("ac_3_coding_mode.zig").Ac3CodingMode;
const Ac3DrcProfile = @import("ac_3_drc_profile.zig").Ac3DrcProfile;
const Ac3LfeFilter = @import("ac_3_lfe_filter.zig").Ac3LfeFilter;
const Ac3MetadataControl = @import("ac_3_metadata_control.zig").Ac3MetadataControl;

/// Ac3 Settings
pub const Ac3Settings = struct {
    /// Applies a 3 dB attenuation to the surround channels. Applies only when the
    /// coding mode parameter is CODING_MODE_3_2_LFE.
    attenuation_control: ?Ac3AttenuationControl,

    /// Average bitrate in bits/second. Valid bitrates depend on the coding mode.
    bitrate: ?f64,

    /// Specifies the bitstream mode (bsmod) for the emitted AC-3 stream. See ATSC
    /// A/52-2012 for background on these values.
    bitstream_mode: ?Ac3BitstreamMode,

    /// Dolby Digital coding mode. Determines number of channels.
    coding_mode: ?Ac3CodingMode,

    /// Sets the dialnorm for the output. If excluded and input audio is Dolby
    /// Digital, dialnorm will be passed through.
    dialnorm: ?i32,

    /// If set to filmStandard, adds dynamic range compression signaling to the
    /// output bitstream as defined in the Dolby Digital specification.
    drc_profile: ?Ac3DrcProfile,

    /// When set to enabled, applies a 120Hz lowpass filter to the LFE channel prior
    /// to encoding. Only valid in codingMode32Lfe mode.
    lfe_filter: ?Ac3LfeFilter,

    /// When set to "followInput", encoder metadata will be sourced from the DD,
    /// DD+, or DolbyE decoder that supplied this audio data. If audio was not
    /// supplied from one of these streams, then the static metadata settings will
    /// be used.
    metadata_control: ?Ac3MetadataControl,

    pub const json_field_names = .{
        .attenuation_control = "AttenuationControl",
        .bitrate = "Bitrate",
        .bitstream_mode = "BitstreamMode",
        .coding_mode = "CodingMode",
        .dialnorm = "Dialnorm",
        .drc_profile = "DrcProfile",
        .lfe_filter = "LfeFilter",
        .metadata_control = "MetadataControl",
    };
};
