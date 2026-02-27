const XavcHdProfileBitrateClass = @import("xavc_hd_profile_bitrate_class.zig").XavcHdProfileBitrateClass;
const XavcFlickerAdaptiveQuantization = @import("xavc_flicker_adaptive_quantization.zig").XavcFlickerAdaptiveQuantization;
const XavcGopBReference = @import("xavc_gop_b_reference.zig").XavcGopBReference;
const XavcInterlaceMode = @import("xavc_interlace_mode.zig").XavcInterlaceMode;
const XavcHdProfileQualityTuningLevel = @import("xavc_hd_profile_quality_tuning_level.zig").XavcHdProfileQualityTuningLevel;
const XavcHdProfileTelecine = @import("xavc_hd_profile_telecine.zig").XavcHdProfileTelecine;

/// Required when you set Profile to the value XAVC_HD.
pub const XavcHdProfileSettings = struct {
    /// Specify the XAVC HD (Long GOP) Bitrate Class to set the bitrate of your
    /// output. Outputs of the same class have similar image quality over the
    /// operating points that are valid for that class.
    bitrate_class: ?XavcHdProfileBitrateClass,

    /// The best way to set up adaptive quantization is to keep the default value,
    /// Auto, for the setting Adaptive quantization. When you do so, MediaConvert
    /// automatically applies the best types of quantization for your video content.
    /// Include this setting in your JSON job specification only when you choose to
    /// change the default value for Adaptive quantization. Enable this setting to
    /// have the encoder reduce I-frame pop. I-frame pop appears as a visual flicker
    /// that can arise when the encoder saves bits by copying some macroblocks many
    /// times from frame to frame, and then refreshes them at the I-frame. When you
    /// enable this setting, the encoder updates these macroblocks slightly more
    /// often to smooth out the flicker. This setting is disabled by default.
    /// Related setting: In addition to enabling this setting, you must also set
    /// Adaptive quantization to a value other than Off or Auto. Use Adaptive
    /// quantization to adjust the degree of smoothing that Flicker adaptive
    /// quantization provides.
    flicker_adaptive_quantization: ?XavcFlickerAdaptiveQuantization,

    /// Specify whether the encoder uses B-frames as reference frames for other
    /// pictures in the same GOP. Choose Allow to allow the encoder to use B-frames
    /// as reference frames. Choose Don't allow to prevent the encoder from using
    /// B-frames as reference frames.
    gop_b_reference: ?XavcGopBReference,

    /// Frequency of closed GOPs. In streaming applications, it is recommended that
    /// this be set to 1 so a decoder joining mid-stream will receive an IDR frame
    /// as quickly as possible. Setting this value to 0 will break output
    /// segmenting.
    gop_closed_cadence: ?i32,

    /// Specify the size of the buffer that MediaConvert uses in the HRD buffer
    /// model for this output. Specify this value in bits; for example, enter five
    /// megabits as 5000000. When you don't set this value, or you set it to zero,
    /// MediaConvert calculates the default by doubling the bitrate of this output
    /// point.
    hrd_buffer_size: ?i32,

    /// Choose the scan line type for the output. Keep the default value,
    /// Progressive to create a progressive output, regardless of the scan type of
    /// your input. Use Top field first or Bottom field first to create an output
    /// that's interlaced with the same field polarity throughout. Use Follow,
    /// default top or Follow, default bottom to produce outputs with the same field
    /// polarity as the source. For jobs that have multiple inputs, the output field
    /// polarity might change over the course of the output. Follow behavior depends
    /// on the input scan type. If the source is interlaced, the output will be
    /// interlaced with the same polarity as the source. If the source is
    /// progressive, the output will be interlaced with top field bottom field
    /// first, depending on which of the Follow options you choose.
    interlace_mode: ?XavcInterlaceMode,

    /// Optional. Use Quality tuning level to choose how you want to trade off
    /// encoding speed for output video quality. The default behavior is faster,
    /// lower quality, single-pass encoding.
    quality_tuning_level: ?XavcHdProfileQualityTuningLevel,

    /// Number of slices per picture. Must be less than or equal to the number of
    /// macroblock rows for progressive pictures, and less than or equal to half the
    /// number of macroblock rows for interlaced pictures.
    slices: ?i32,

    /// Ignore this setting unless you set Frame rate (framerateNumerator divided by
    /// framerateDenominator) to 29.970. If your input framerate is 23.976, choose
    /// Hard. Otherwise, keep the default value None. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/working-with-telecine-and-inverse-telecine.html.
    telecine: ?XavcHdProfileTelecine,

    pub const json_field_names = .{
        .bitrate_class = "BitrateClass",
        .flicker_adaptive_quantization = "FlickerAdaptiveQuantization",
        .gop_b_reference = "GopBReference",
        .gop_closed_cadence = "GopClosedCadence",
        .hrd_buffer_size = "HrdBufferSize",
        .interlace_mode = "InterlaceMode",
        .quality_tuning_level = "QualityTuningLevel",
        .slices = "Slices",
        .telecine = "Telecine",
    };
};
