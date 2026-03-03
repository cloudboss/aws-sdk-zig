const Eac3AttenuationControl = @import("eac_3_attenuation_control.zig").Eac3AttenuationControl;
const Eac3BitstreamMode = @import("eac_3_bitstream_mode.zig").Eac3BitstreamMode;
const Eac3CodingMode = @import("eac_3_coding_mode.zig").Eac3CodingMode;
const Eac3DcFilter = @import("eac_3_dc_filter.zig").Eac3DcFilter;
const Eac3DynamicRangeCompressionLine = @import("eac_3_dynamic_range_compression_line.zig").Eac3DynamicRangeCompressionLine;
const Eac3DynamicRangeCompressionRf = @import("eac_3_dynamic_range_compression_rf.zig").Eac3DynamicRangeCompressionRf;
const Eac3LfeControl = @import("eac_3_lfe_control.zig").Eac3LfeControl;
const Eac3LfeFilter = @import("eac_3_lfe_filter.zig").Eac3LfeFilter;
const Eac3MetadataControl = @import("eac_3_metadata_control.zig").Eac3MetadataControl;
const Eac3PassthroughControl = @import("eac_3_passthrough_control.zig").Eac3PassthroughControl;
const Eac3PhaseControl = @import("eac_3_phase_control.zig").Eac3PhaseControl;
const Eac3StereoDownmix = @import("eac_3_stereo_downmix.zig").Eac3StereoDownmix;
const Eac3SurroundExMode = @import("eac_3_surround_ex_mode.zig").Eac3SurroundExMode;
const Eac3SurroundMode = @import("eac_3_surround_mode.zig").Eac3SurroundMode;

/// Required when you set Codec to the value EAC3.
pub const Eac3Settings = struct {
    /// If set to ATTENUATE_3_DB, applies a 3 dB attenuation to the surround
    /// channels. Only used for 3/2 coding mode.
    attenuation_control: ?Eac3AttenuationControl = null,

    /// Specify the average bitrate in bits per second. The bitrate that you specify
    /// must be a multiple of 8000 within the allowed minimum and maximum values.
    /// Leave blank to use the default bitrate for the coding mode you select
    /// according ETSI TS 102 366. Valid bitrates for coding mode 1/0: Default:
    /// 96000. Minimum: 32000. Maximum: 3024000. Valid bitrates for coding mode 2/0:
    /// Default: 192000. Minimum: 96000. Maximum: 3024000. Valid bitrates for coding
    /// mode 3/2: Default: 384000. Minimum: 192000. Maximum: 3024000.
    bitrate: ?i32 = null,

    /// Specify the bitstream mode for the E-AC-3 stream that the encoder emits. For
    /// more information about the EAC3 bitstream mode, see ATSC A/52-2012 (Annex
    /// E).
    bitstream_mode: ?Eac3BitstreamMode = null,

    /// Dolby Digital Plus coding mode. Determines number of channels.
    coding_mode: ?Eac3CodingMode = null,

    /// Activates a DC highpass filter for all input channels.
    dc_filter: ?Eac3DcFilter = null,

    /// Sets the dialnorm for the output. If blank and input audio is Dolby Digital
    /// Plus, dialnorm will be passed through.
    dialnorm: ?i32 = null,

    /// Choose the Dolby Digital dynamic range control (DRC) profile that
    /// MediaConvert uses when encoding the metadata in the Dolby Digital stream for
    /// the line operating mode. Related setting: When you use this setting,
    /// MediaConvert ignores any value you provide for Dynamic range compression
    /// profile. For information about the Dolby Digital DRC operating modes and
    /// profiles, see the Dynamic Range Control chapter of the Dolby Metadata Guide
    /// at
    /// https://developer.dolby.com/globalassets/professional/documents/dolby-metadata-guide.pdf.
    dynamic_range_compression_line: ?Eac3DynamicRangeCompressionLine = null,

    /// Choose the Dolby Digital dynamic range control (DRC) profile that
    /// MediaConvert uses when encoding the metadata in the Dolby Digital stream for
    /// the RF operating mode. Related setting: When you use this setting,
    /// MediaConvert ignores any value you provide for Dynamic range compression
    /// profile. For information about the Dolby Digital DRC operating modes and
    /// profiles, see the Dynamic Range Control chapter of the Dolby Metadata Guide
    /// at
    /// https://developer.dolby.com/globalassets/professional/documents/dolby-metadata-guide.pdf.
    dynamic_range_compression_rf: ?Eac3DynamicRangeCompressionRf = null,

    /// When encoding 3/2 audio, controls whether the LFE channel is enabled
    lfe_control: ?Eac3LfeControl = null,

    /// Applies a 120Hz lowpass filter to the LFE channel prior to encoding. Only
    /// valid with 3_2_LFE coding mode.
    lfe_filter: ?Eac3LfeFilter = null,

    /// Specify a value for the following Dolby Digital Plus setting: Left
    /// only/Right only center mix. MediaConvert uses this value for downmixing. How
    /// the service uses this value depends on the value that you choose for Stereo
    /// downmix. Valid values: 3.0, 1.5, 0.0, -1.5, -3.0, -4.5, -6.0, and -60. The
    /// value -60 mutes the channel. This setting applies only if you keep the
    /// default value of 3/2 - L, R, C, Ls, Rs for the setting Coding mode. If you
    /// choose a different value for Coding mode, the service ignores Left
    /// only/Right only center.
    lo_ro_center_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby Digital Plus setting: Left
    /// only/Right only. MediaConvert uses this value for downmixing. How the
    /// service uses this value depends on the value that you choose for Stereo
    /// downmix. Valid values: -1.5, -3.0, -4.5, -6.0, and -60. The value -60 mutes
    /// the channel. This setting applies only if you keep the default value of 3/2
    /// - L, R, C, Ls, Rs for the setting Coding mode. If you choose a different
    /// value for Coding mode, the service ignores Left only/Right only surround.
    lo_ro_surround_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby Digital Plus setting: Left
    /// total/Right total center mix. MediaConvert uses this value for downmixing.
    /// How the service uses this value depends on the value that you choose for
    /// Stereo downmix. Valid values: 3.0, 1.5, 0.0, -1.5, -3.0, -4.5, -6.0, and
    /// -60. The value -60 mutes the channel. This setting applies only if you keep
    /// the default value of 3/2 - L, R, C, Ls, Rs for the setting Coding mode. If
    /// you choose a different value for Coding mode, the service ignores Left
    /// total/Right total center.
    lt_rt_center_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby Digital Plus setting: Left
    /// total/Right total surround mix. MediaConvert uses this value for downmixing.
    /// How the service uses this value depends on the value that you choose for
    /// Stereo downmix. Valid values: -1.5, -3.0, -4.5, -6.0, and -60. The value -60
    /// mutes the channel. This setting applies only if you keep the default value
    /// of 3/2 - L, R, C, Ls, Rs for the setting Coding mode. If you choose a
    /// different value for Coding mode, the service ignores Left total/Right total
    /// surround.
    lt_rt_surround_mix_level: ?f64 = null,

    /// When set to FOLLOW_INPUT, encoder metadata will be sourced from the DD, DD+,
    /// or DolbyE decoder that supplied this audio data. If audio was not supplied
    /// from one of these streams, then the static metadata settings will be used.
    metadata_control: ?Eac3MetadataControl = null,

    /// When set to WHEN_POSSIBLE, input DD+ audio will be passed through if it is
    /// present on the input. this detection is dynamic over the life of the
    /// transcode. Inputs that alternate between DD+ and non-DD+ content will have a
    /// consistent DD+ output as the system alternates between passthrough and
    /// encoding.
    passthrough_control: ?Eac3PassthroughControl = null,

    /// Controls the amount of phase-shift applied to the surround channels. Only
    /// used for 3/2 coding mode.
    phase_control: ?Eac3PhaseControl = null,

    /// This value is always 48000. It represents the sample rate in Hz.
    sample_rate: ?i32 = null,

    /// Choose how the service does stereo downmixing. This setting only applies if
    /// you keep the default value of 3/2 - L, R, C, Ls, Rs for the setting Coding
    /// mode. If you choose a different value for Coding mode, the service ignores
    /// Stereo downmix.
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
        .dynamic_range_compression_line = "DynamicRangeCompressionLine",
        .dynamic_range_compression_rf = "DynamicRangeCompressionRf",
        .lfe_control = "LfeControl",
        .lfe_filter = "LfeFilter",
        .lo_ro_center_mix_level = "LoRoCenterMixLevel",
        .lo_ro_surround_mix_level = "LoRoSurroundMixLevel",
        .lt_rt_center_mix_level = "LtRtCenterMixLevel",
        .lt_rt_surround_mix_level = "LtRtSurroundMixLevel",
        .metadata_control = "MetadataControl",
        .passthrough_control = "PassthroughControl",
        .phase_control = "PhaseControl",
        .sample_rate = "SampleRate",
        .stereo_downmix = "StereoDownmix",
        .surround_ex_mode = "SurroundExMode",
        .surround_mode = "SurroundMode",
    };
};
