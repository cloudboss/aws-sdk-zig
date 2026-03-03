const Eac3AttenuationControl = @import("eac_3_attenuation_control.zig").Eac3AttenuationControl;
const Eac3BitstreamMode = @import("eac_3_bitstream_mode.zig").Eac3BitstreamMode;
const Eac3CodingMode = @import("eac_3_coding_mode.zig").Eac3CodingMode;
const Eac3DcFilter = @import("eac_3_dc_filter.zig").Eac3DcFilter;
const Eac3DrcLine = @import("eac_3_drc_line.zig").Eac3DrcLine;
const Eac3DrcRf = @import("eac_3_drc_rf.zig").Eac3DrcRf;
const Eac3LfeControl = @import("eac_3_lfe_control.zig").Eac3LfeControl;
const Eac3LfeFilter = @import("eac_3_lfe_filter.zig").Eac3LfeFilter;
const Eac3MetadataControl = @import("eac_3_metadata_control.zig").Eac3MetadataControl;
const Eac3PassthroughControl = @import("eac_3_passthrough_control.zig").Eac3PassthroughControl;
const Eac3PhaseControl = @import("eac_3_phase_control.zig").Eac3PhaseControl;
const Eac3StereoDownmix = @import("eac_3_stereo_downmix.zig").Eac3StereoDownmix;
const Eac3SurroundExMode = @import("eac_3_surround_ex_mode.zig").Eac3SurroundExMode;
const Eac3SurroundMode = @import("eac_3_surround_mode.zig").Eac3SurroundMode;

/// Eac3 Settings
pub const Eac3Settings = struct {
    /// When set to attenuate3Db, applies a 3 dB attenuation to the surround
    /// channels. Only used for 3/2 coding mode.
    attenuation_control: ?Eac3AttenuationControl = null,

    /// Average bitrate in bits/second. Valid bitrates depend on the coding mode.
    bitrate: ?f64 = null,

    /// Specifies the bitstream mode (bsmod) for the emitted E-AC-3 stream. See ATSC
    /// A/52-2012 (Annex E) for background on these values.
    bitstream_mode: ?Eac3BitstreamMode = null,

    /// Dolby Digital Plus coding mode. Determines number of channels.
    coding_mode: ?Eac3CodingMode = null,

    /// When set to enabled, activates a DC highpass filter for all input channels.
    dc_filter: ?Eac3DcFilter = null,

    /// Sets the dialnorm for the output. If blank and input audio is Dolby Digital
    /// Plus, dialnorm will be passed through.
    dialnorm: ?i32 = null,

    /// Sets the Dolby dynamic range compression profile.
    drc_line: ?Eac3DrcLine = null,

    /// Sets the profile for heavy Dolby dynamic range compression, ensures that the
    /// instantaneous signal peaks do not exceed specified levels.
    drc_rf: ?Eac3DrcRf = null,

    /// When encoding 3/2 audio, setting to lfe enables the LFE channel
    lfe_control: ?Eac3LfeControl = null,

    /// When set to enabled, applies a 120Hz lowpass filter to the LFE channel prior
    /// to encoding. Only valid with codingMode32 coding mode.
    lfe_filter: ?Eac3LfeFilter = null,

    /// Left only/Right only center mix level. Only used for 3/2 coding mode.
    lo_ro_center_mix_level: ?f64 = null,

    /// Left only/Right only surround mix level. Only used for 3/2 coding mode.
    lo_ro_surround_mix_level: ?f64 = null,

    /// Left total/Right total center mix level. Only used for 3/2 coding mode.
    lt_rt_center_mix_level: ?f64 = null,

    /// Left total/Right total surround mix level. Only used for 3/2 coding mode.
    lt_rt_surround_mix_level: ?f64 = null,

    /// When set to followInput, encoder metadata will be sourced from the DD, DD+,
    /// or DolbyE decoder that supplied this audio data. If audio was not supplied
    /// from one of these streams, then the static metadata settings will be used.
    metadata_control: ?Eac3MetadataControl = null,

    /// When set to whenPossible, input DD+ audio will be passed through if it is
    /// present on the input. This detection is dynamic over the life of the
    /// transcode. Inputs that alternate between DD+ and non-DD+ content will have a
    /// consistent DD+ output as the system alternates between passthrough and
    /// encoding.
    passthrough_control: ?Eac3PassthroughControl = null,

    /// When set to shift90Degrees, applies a 90-degree phase shift to the surround
    /// channels. Only used for 3/2 coding mode.
    phase_control: ?Eac3PhaseControl = null,

    /// Stereo downmix preference. Only used for 3/2 coding mode.
    stereo_downmix: ?Eac3StereoDownmix = null,

    /// When encoding 3/2 audio, sets whether an extra center back surround channel
    /// is matrix encoded into the left and right surround channels.
    surround_ex_mode: ?Eac3SurroundExMode = null,

    /// When encoding 2/0 audio, sets whether Dolby Surround is matrix encoded into
    /// the two channels.
    surround_mode: ?Eac3SurroundMode = null,

    pub const json_field_names = .{
        .attenuation_control = "AttenuationControl",
        .bitrate = "Bitrate",
        .bitstream_mode = "BitstreamMode",
        .coding_mode = "CodingMode",
        .dc_filter = "DcFilter",
        .dialnorm = "Dialnorm",
        .drc_line = "DrcLine",
        .drc_rf = "DrcRf",
        .lfe_control = "LfeControl",
        .lfe_filter = "LfeFilter",
        .lo_ro_center_mix_level = "LoRoCenterMixLevel",
        .lo_ro_surround_mix_level = "LoRoSurroundMixLevel",
        .lt_rt_center_mix_level = "LtRtCenterMixLevel",
        .lt_rt_surround_mix_level = "LtRtSurroundMixLevel",
        .metadata_control = "MetadataControl",
        .passthrough_control = "PassthroughControl",
        .phase_control = "PhaseControl",
        .stereo_downmix = "StereoDownmix",
        .surround_ex_mode = "SurroundExMode",
        .surround_mode = "SurroundMode",
    };
};
