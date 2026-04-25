const Ac4BitstreamMode = @import("ac_4_bitstream_mode.zig").Ac4BitstreamMode;
const Ac4CodingMode = @import("ac_4_coding_mode.zig").Ac4CodingMode;
const Ac4DynamicRangeCompressionDrcProfile = @import("ac_4_dynamic_range_compression_drc_profile.zig").Ac4DynamicRangeCompressionDrcProfile;
const Ac4StereoDownmix = @import("ac_4_stereo_downmix.zig").Ac4StereoDownmix;

/// Required when you set Codec to the value AC4.
pub const Ac4Settings = struct {
    /// Specify the average bitrate in bits per second. Leave blank to use the
    /// default bitrate for the coding mode you select according to ETSI TS 103 190.
    /// Valid bitrates for coding mode 2.0 (stereo): 48000, 64000, 96000, 128000,
    /// 144000, 192000, 256000, 288000, 320000, 384000, 448000, 512000, or 768000.
    /// Valid bitrates for coding mode 5.1 (3/2 with LFE): 96000, 128000, 144000,
    /// 192000, 256000, 288000, 320000, 384000, 448000, 512000, or 768000. Valid
    /// bitrates for coding mode 5.1.4 (immersive): 192000, 256000, 288000, 320000,
    /// 384000, 448000, 512000, or 768000.
    bitrate: ?i32 = null,

    /// Specify the bitstream mode for the AC-4 stream that the encoder emits. For
    /// more information about the AC-4 bitstream mode, see ETSI TS 103 190. Maps to
    /// dlb_paec_ac4_bed_classifier in the encoder implementation. - COMPLETE_MAIN:
    /// Complete Main (standard mix) - EMERGENCY: Stereo Emergency content
    bitstream_mode: ?Ac4BitstreamMode = null,

    /// Dolby AC-4 coding mode. Determines number of channels. Maps to
    /// dlb_paec_ac4_bed_channel_config in the encoder implementation. -
    /// CODING_MODE_2_0: 2.0 (stereo) - maps to DLB_PAEC_AC4_BED_CHANNEL_CONFIG_20 -
    /// CODING_MODE_3_2_LFE: 5.1 surround - maps to
    /// DLB_PAEC_AC4_BED_CHANNEL_CONFIG_51 - CODING_MODE_5_1_4: 5.1.4 immersive -
    /// maps to DLB_PAEC_AC4_BED_CHANNEL_CONFIG_514
    coding_mode: ?Ac4CodingMode = null,

    /// Choose the Dolby AC-4 dynamic range control (DRC) profile that MediaConvert
    /// uses when encoding the metadata in the Dolby AC-4 stream for the specified
    /// decoder mode. For information about the Dolby AC-4 DRC profiles, see the
    /// Dolby AC-4 specification.
    dynamic_range_compression_flat_panel_tv: ?Ac4DynamicRangeCompressionDrcProfile = null,

    /// Choose the Dolby AC-4 dynamic range control (DRC) profile that MediaConvert
    /// uses when encoding the metadata in the Dolby AC-4 stream for the specified
    /// decoder mode. For information about the Dolby AC-4 DRC profiles, see the
    /// Dolby AC-4 specification.
    dynamic_range_compression_home_theater: ?Ac4DynamicRangeCompressionDrcProfile = null,

    /// Choose the Dolby AC-4 dynamic range control (DRC) profile that MediaConvert
    /// uses when encoding the metadata in the Dolby AC-4 stream for the specified
    /// decoder mode. For information about the Dolby AC-4 DRC profiles, see the
    /// Dolby AC-4 specification.
    dynamic_range_compression_portable_headphones: ?Ac4DynamicRangeCompressionDrcProfile = null,

    /// Choose the Dolby AC-4 dynamic range control (DRC) profile that MediaConvert
    /// uses when encoding the metadata in the Dolby AC-4 stream for the specified
    /// decoder mode. For information about the Dolby AC-4 DRC profiles, see the
    /// Dolby AC-4 specification.
    dynamic_range_compression_portable_speakers: ?Ac4DynamicRangeCompressionDrcProfile = null,

    /// Specify a value for the following Dolby AC-4 setting: Left only/Right only
    /// center mix. MediaConvert uses this value for downmixing. How the service
    /// uses this value depends on the value that you choose for Stereo downmix.
    /// Valid values: 3.0, 1.5, 0.0, -1.5, -3.0, -4.5, -6.0, and -infinity. The
    /// value -infinity mutes the channel. This setting applies only if you keep the
    /// default value of 3/2 - L, R, C, Ls, Rs for the setting Coding mode. If you
    /// choose a different value for Coding mode, the service ignores Left
    /// only/Right only center.
    lo_ro_center_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby AC-4 setting: Left only/Right only
    /// surround mix. MediaConvert uses this value for downmixing. How the service
    /// uses this value depends on the value that you choose for Stereo downmix.
    /// Valid values: -1.5, -3.0, -4.5, -6.0, and -infinity. The value -infinity
    /// mutes the channel. This setting applies only if you keep the default value
    /// of 3/2 - L, R, C, Ls, Rs for the setting Coding mode. If you choose a
    /// different value for Coding mode, the service ignores Left only/Right only
    /// surround.
    lo_ro_surround_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby AC-4 setting: Left total/Right total
    /// center mix. MediaConvert uses this value for downmixing. How the service
    /// uses this value depends on the value that you choose for Stereo downmix.
    /// Valid values: 3.0, 1.5, 0.0, -1.5, -3.0, -4.5, -6.0, and -infinity. The
    /// value -infinity mutes the channel. This setting applies only if you keep the
    /// default value of 3/2 - L, R, C, Ls, Rs for the setting Coding mode. If you
    /// choose a different value for Coding mode, the service ignores Left
    /// total/Right total center.
    lt_rt_center_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby AC-4 setting: Left total/Right total
    /// surround mix. MediaConvert uses this value for downmixing. How the service
    /// uses this value depends on the value that you choose for Stereo downmix.
    /// Valid values: -1.5, -3.0, -4.5, -6.0, and -infinity. The value -infinity
    /// mutes the channel. This setting applies only if you keep the default value
    /// of 3/2 - L, R, C, Ls, Rs for the setting Coding mode. If you choose a
    /// different value for Coding mode, the service ignores Left total/Right total
    /// surround.
    lt_rt_surround_mix_level: ?f64 = null,

    /// This value is always 48000. It represents the sample rate in Hz.
    sample_rate: ?i32 = null,

    /// Choose the preferred stereo downmix method. This setting tells the decoder
    /// how to downmix multi-channel audio to stereo during playback.
    stereo_downmix: ?Ac4StereoDownmix = null,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .bitstream_mode = "BitstreamMode",
        .coding_mode = "CodingMode",
        .dynamic_range_compression_flat_panel_tv = "DynamicRangeCompressionFlatPanelTv",
        .dynamic_range_compression_home_theater = "DynamicRangeCompressionHomeTheater",
        .dynamic_range_compression_portable_headphones = "DynamicRangeCompressionPortableHeadphones",
        .dynamic_range_compression_portable_speakers = "DynamicRangeCompressionPortableSpeakers",
        .lo_ro_center_mix_level = "LoRoCenterMixLevel",
        .lo_ro_surround_mix_level = "LoRoSurroundMixLevel",
        .lt_rt_center_mix_level = "LtRtCenterMixLevel",
        .lt_rt_surround_mix_level = "LtRtSurroundMixLevel",
        .sample_rate = "SampleRate",
        .stereo_downmix = "StereoDownmix",
    };
};
