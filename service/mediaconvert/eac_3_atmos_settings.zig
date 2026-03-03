const Eac3AtmosBitstreamMode = @import("eac_3_atmos_bitstream_mode.zig").Eac3AtmosBitstreamMode;
const Eac3AtmosCodingMode = @import("eac_3_atmos_coding_mode.zig").Eac3AtmosCodingMode;
const Eac3AtmosDialogueIntelligence = @import("eac_3_atmos_dialogue_intelligence.zig").Eac3AtmosDialogueIntelligence;
const Eac3AtmosDownmixControl = @import("eac_3_atmos_downmix_control.zig").Eac3AtmosDownmixControl;
const Eac3AtmosDynamicRangeCompressionLine = @import("eac_3_atmos_dynamic_range_compression_line.zig").Eac3AtmosDynamicRangeCompressionLine;
const Eac3AtmosDynamicRangeCompressionRf = @import("eac_3_atmos_dynamic_range_compression_rf.zig").Eac3AtmosDynamicRangeCompressionRf;
const Eac3AtmosDynamicRangeControl = @import("eac_3_atmos_dynamic_range_control.zig").Eac3AtmosDynamicRangeControl;
const Eac3AtmosMeteringMode = @import("eac_3_atmos_metering_mode.zig").Eac3AtmosMeteringMode;
const Eac3AtmosStereoDownmix = @import("eac_3_atmos_stereo_downmix.zig").Eac3AtmosStereoDownmix;
const Eac3AtmosSurroundExMode = @import("eac_3_atmos_surround_ex_mode.zig").Eac3AtmosSurroundExMode;

/// Required when you set Codec to the value EAC3_ATMOS.
pub const Eac3AtmosSettings = struct {
    /// Specify the average bitrate for this output in bits per second. Valid
    /// values: 384k, 448k, 576k, 640k, 768k, 1024k Default value: 448k Note that
    /// MediaConvert supports 384k only with channel-based immersive (CBI) 7.1.4 and
    /// 5.1.4 inputs. For CBI 9.1.6 and other input types, MediaConvert
    /// automatically increases your output bitrate to 448k.
    bitrate: ?i32 = null,

    /// Specify the bitstream mode for the E-AC-3 stream that the encoder emits. For
    /// more information about the EAC3 bitstream mode, see ATSC A/52-2012 (Annex
    /// E).
    bitstream_mode: ?Eac3AtmosBitstreamMode = null,

    /// The coding mode for Dolby Digital Plus JOC (Atmos).
    coding_mode: ?Eac3AtmosCodingMode = null,

    /// Enable Dolby Dialogue Intelligence to adjust loudness based on dialogue
    /// analysis.
    dialogue_intelligence: ?Eac3AtmosDialogueIntelligence = null,

    /// Specify whether MediaConvert should use any downmix metadata from your input
    /// file. Keep the default value, Custom to provide downmix values in your job
    /// settings. Choose Follow source to use the metadata from your input. Related
    /// settings--Use these settings to specify your downmix values: Left only/Right
    /// only surround, Left total/Right total surround, Left total/Right total
    /// center, Left only/Right only center, and Stereo downmix. When you keep
    /// Custom for Downmix control and you don't specify values for the related
    /// settings, MediaConvert uses default values for those settings.
    downmix_control: ?Eac3AtmosDownmixControl = null,

    /// Choose the Dolby dynamic range control (DRC) profile that MediaConvert uses
    /// when encoding the metadata in the Dolby stream for the line operating mode.
    /// Default value: Film light Related setting: To have MediaConvert use the
    /// value you specify here, keep the default value, Custom for the setting
    /// Dynamic range control. Otherwise, MediaConvert ignores Dynamic range
    /// compression line. For information about the Dolby DRC operating modes and
    /// profiles, see the Dynamic Range Control chapter of the Dolby Metadata Guide
    /// at
    /// https://developer.dolby.com/globalassets/professional/documents/dolby-metadata-guide.pdf.
    dynamic_range_compression_line: ?Eac3AtmosDynamicRangeCompressionLine = null,

    /// Choose the Dolby dynamic range control (DRC) profile that MediaConvert uses
    /// when encoding the metadata in the Dolby stream for the RF operating mode.
    /// Default value: Film light Related setting: To have MediaConvert use the
    /// value you specify here, keep the default value, Custom for the setting
    /// Dynamic range control. Otherwise, MediaConvert ignores Dynamic range
    /// compression RF. For information about the Dolby DRC operating modes and
    /// profiles, see the Dynamic Range Control chapter of the Dolby Metadata Guide
    /// at
    /// https://developer.dolby.com/globalassets/professional/documents/dolby-metadata-guide.pdf.
    dynamic_range_compression_rf: ?Eac3AtmosDynamicRangeCompressionRf = null,

    /// Specify whether MediaConvert should use any dynamic range control metadata
    /// from your input file. Keep the default value, Custom, to provide dynamic
    /// range control values in your job settings. Choose Follow source to use the
    /// metadata from your input. Related settings--Use these settings to specify
    /// your dynamic range control values: Dynamic range compression line and
    /// Dynamic range compression RF. When you keep the value Custom for Dynamic
    /// range control and you don't specify values for the related settings,
    /// MediaConvert uses default values for those settings.
    dynamic_range_control: ?Eac3AtmosDynamicRangeControl = null,

    /// Specify a value for the following Dolby Atmos setting: Left only/Right only
    /// center mix (Lo/Ro center). MediaConvert uses this value for downmixing.
    /// Default value: -3 dB. Valid values: 3.0, 1.5, 0.0, -1.5, -3.0, -4.5, and
    /// -6.0. Related setting: How the service uses this value depends on the value
    /// that you choose for Stereo downmix. Related setting: To have MediaConvert
    /// use this value, keep the default value, Custom for the setting Downmix
    /// control. Otherwise, MediaConvert ignores Left only/Right only center.
    lo_ro_center_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby Atmos setting: Left only/Right only.
    /// MediaConvert uses this value for downmixing. Default value: -3 dB. Valid
    /// values: -1.5, -3.0, -4.5, -6.0, and -60. The value -60 mutes the channel.
    /// Related setting: How the service uses this value depends on the value that
    /// you choose for Stereo downmix. Related setting: To have MediaConvert use
    /// this value, keep the default value, Custom for the setting Downmix control.
    /// Otherwise, MediaConvert ignores Left only/Right only surround.
    lo_ro_surround_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby Atmos setting: Left total/Right
    /// total center mix (Lt/Rt center). MediaConvert uses this value for
    /// downmixing. Default value: -3 dB Valid values: 3.0, 1.5, 0.0, -1.5, -3.0,
    /// -4.5, and -6.0. Related setting: How the service uses this value depends on
    /// the value that you choose for Stereo downmix. Related setting: To have
    /// MediaConvert use this value, keep the default value, Custom for the setting
    /// Downmix control. Otherwise, MediaConvert ignores Left total/Right total
    /// center.
    lt_rt_center_mix_level: ?f64 = null,

    /// Specify a value for the following Dolby Atmos setting: Left total/Right
    /// total surround mix (Lt/Rt surround). MediaConvert uses this value for
    /// downmixing. Default value: -3 dB Valid values: -1.5, -3.0, -4.5, -6.0, and
    /// -60. The value -60 mutes the channel. Related setting: How the service uses
    /// this value depends on the value that you choose for Stereo downmix. Related
    /// setting: To have MediaConvert use this value, keep the default value, Custom
    /// for the setting Downmix control. Otherwise, the service ignores Left
    /// total/Right total surround.
    lt_rt_surround_mix_level: ?f64 = null,

    /// Choose how the service meters the loudness of your audio.
    metering_mode: ?Eac3AtmosMeteringMode = null,

    /// This value is always 48000. It represents the sample rate in Hz.
    sample_rate: ?i32 = null,

    /// Specify the percentage of audio content, from 0% to 100%, that must be
    /// speech in order for the encoder to use the measured speech loudness as the
    /// overall program loudness. Default value: 15%
    speech_threshold: ?i32 = null,

    /// Choose how the service does stereo downmixing. Default value: Not indicated
    /// Related setting: To have MediaConvert use this value, keep the default
    /// value, Custom for the setting Downmix control. Otherwise, MediaConvert
    /// ignores Stereo downmix.
    stereo_downmix: ?Eac3AtmosStereoDownmix = null,

    /// Specify whether your input audio has an additional center rear surround
    /// channel matrix encoded into your left and right surround channels.
    surround_ex_mode: ?Eac3AtmosSurroundExMode = null,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .bitstream_mode = "BitstreamMode",
        .coding_mode = "CodingMode",
        .dialogue_intelligence = "DialogueIntelligence",
        .downmix_control = "DownmixControl",
        .dynamic_range_compression_line = "DynamicRangeCompressionLine",
        .dynamic_range_compression_rf = "DynamicRangeCompressionRf",
        .dynamic_range_control = "DynamicRangeControl",
        .lo_ro_center_mix_level = "LoRoCenterMixLevel",
        .lo_ro_surround_mix_level = "LoRoSurroundMixLevel",
        .lt_rt_center_mix_level = "LtRtCenterMixLevel",
        .lt_rt_surround_mix_level = "LtRtSurroundMixLevel",
        .metering_mode = "MeteringMode",
        .sample_rate = "SampleRate",
        .speech_threshold = "SpeechThreshold",
        .stereo_downmix = "StereoDownmix",
        .surround_ex_mode = "SurroundExMode",
    };
};
