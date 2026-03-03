const Ac3BitstreamMode = @import("ac_3_bitstream_mode.zig").Ac3BitstreamMode;
const Ac3CodingMode = @import("ac_3_coding_mode.zig").Ac3CodingMode;
const Ac3DynamicRangeCompressionLine = @import("ac_3_dynamic_range_compression_line.zig").Ac3DynamicRangeCompressionLine;
const Ac3DynamicRangeCompressionProfile = @import("ac_3_dynamic_range_compression_profile.zig").Ac3DynamicRangeCompressionProfile;
const Ac3DynamicRangeCompressionRf = @import("ac_3_dynamic_range_compression_rf.zig").Ac3DynamicRangeCompressionRf;
const Ac3LfeFilter = @import("ac_3_lfe_filter.zig").Ac3LfeFilter;
const Ac3MetadataControl = @import("ac_3_metadata_control.zig").Ac3MetadataControl;

/// Required when you set Codec to the value AC3.
pub const Ac3Settings = struct {
    /// Specify the average bitrate in bits per second. The bitrate that you specify
    /// must be a multiple of 8000 within the allowed minimum and maximum values.
    /// Leave blank to use the default bitrate for the coding mode you select
    /// according ETSI TS 102 366. Valid bitrates for coding mode 1/0: Default:
    /// 96000. Minimum: 64000. Maximum: 128000. Valid bitrates for coding mode 1/1:
    /// Default: 192000. Minimum: 128000. Maximum: 384000. Valid bitrates for coding
    /// mode 2/0: Default: 192000. Minimum: 128000. Maximum: 384000. Valid bitrates
    /// for coding mode 3/2 with FLE: Default: 384000. Minimum: 384000. Maximum:
    /// 640000.
    bitrate: ?i32 = null,

    /// Specify the bitstream mode for the AC-3 stream that the encoder emits. For
    /// more information about the AC3 bitstream mode, see ATSC A/52-2012 (Annex E).
    bitstream_mode: ?Ac3BitstreamMode = null,

    /// Dolby Digital coding mode. Determines number of channels.
    coding_mode: ?Ac3CodingMode = null,

    /// Sets the dialnorm for the output. If blank and input audio is Dolby Digital,
    /// dialnorm will be passed through.
    dialnorm: ?i32 = null,

    /// Choose the Dolby Digital dynamic range control (DRC) profile that
    /// MediaConvert uses when encoding the metadata in the Dolby Digital stream for
    /// the line operating mode. Related setting: When you use this setting,
    /// MediaConvert ignores any value you provide for Dynamic range compression
    /// profile. For information about the Dolby Digital DRC operating modes and
    /// profiles, see the Dynamic Range Control chapter of the Dolby Metadata Guide
    /// at
    /// https://developer.dolby.com/globalassets/professional/documents/dolby-metadata-guide.pdf.
    dynamic_range_compression_line: ?Ac3DynamicRangeCompressionLine = null,

    /// When you want to add Dolby dynamic range compression (DRC) signaling to your
    /// output stream, we recommend that you use the mode-specific settings instead
    /// of Dynamic range compression profile. The mode-specific settings are Dynamic
    /// range compression profile, line mode and Dynamic range compression profile,
    /// RF mode. Note that when you specify values for all three settings,
    /// MediaConvert ignores the value of this setting in favor of the mode-specific
    /// settings. If you do use this setting instead of the mode-specific settings,
    /// choose None to leave out DRC signaling. Keep the default Film standard to
    /// set the profile to Dolby's film standard profile for all operating modes.
    dynamic_range_compression_profile: ?Ac3DynamicRangeCompressionProfile = null,

    /// Choose the Dolby Digital dynamic range control (DRC) profile that
    /// MediaConvert uses when encoding the metadata in the Dolby Digital stream for
    /// the RF operating mode. Related setting: When you use this setting,
    /// MediaConvert ignores any value you provide for Dynamic range compression
    /// profile. For information about the Dolby Digital DRC operating modes and
    /// profiles, see the Dynamic Range Control chapter of the Dolby Metadata Guide
    /// at
    /// https://developer.dolby.com/globalassets/professional/documents/dolby-metadata-guide.pdf.
    dynamic_range_compression_rf: ?Ac3DynamicRangeCompressionRf = null,

    /// Applies a 120Hz lowpass filter to the LFE channel prior to encoding. Only
    /// valid with 3_2_LFE coding mode.
    lfe_filter: ?Ac3LfeFilter = null,

    /// When set to FOLLOW_INPUT, encoder metadata will be sourced from the DD, DD+,
    /// or DolbyE decoder that supplied this audio data. If audio was not supplied
    /// from one of these streams, then the static metadata settings will be used.
    metadata_control: ?Ac3MetadataControl = null,

    /// This value is always 48000. It represents the sample rate in Hz.
    sample_rate: ?i32 = null,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .bitstream_mode = "BitstreamMode",
        .coding_mode = "CodingMode",
        .dialnorm = "Dialnorm",
        .dynamic_range_compression_line = "DynamicRangeCompressionLine",
        .dynamic_range_compression_profile = "DynamicRangeCompressionProfile",
        .dynamic_range_compression_rf = "DynamicRangeCompressionRf",
        .lfe_filter = "LfeFilter",
        .metadata_control = "MetadataControl",
        .sample_rate = "SampleRate",
    };
};
