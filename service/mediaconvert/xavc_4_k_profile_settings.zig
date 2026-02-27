const Xavc4kProfileBitrateClass = @import("xavc_4_k_profile_bitrate_class.zig").Xavc4kProfileBitrateClass;
const Xavc4kProfileCodecProfile = @import("xavc_4_k_profile_codec_profile.zig").Xavc4kProfileCodecProfile;
const XavcFlickerAdaptiveQuantization = @import("xavc_flicker_adaptive_quantization.zig").XavcFlickerAdaptiveQuantization;
const XavcGopBReference = @import("xavc_gop_b_reference.zig").XavcGopBReference;
const Xavc4kProfileQualityTuningLevel = @import("xavc_4_k_profile_quality_tuning_level.zig").Xavc4kProfileQualityTuningLevel;

/// Required when you set Profile to the value XAVC_4K.
pub const Xavc4kProfileSettings = struct {
    /// Specify the XAVC 4k (Long GOP) Bitrate Class to set the bitrate of your
    /// output. Outputs of the same class have similar image quality over the
    /// operating points that are valid for that class.
    bitrate_class: ?Xavc4kProfileBitrateClass,

    /// Specify the codec profile for this output. Choose High, 8-bit, 4:2:0 (HIGH)
    /// or High, 10-bit, 4:2:2 (HIGH_422). These profiles are specified in ITU-T
    /// H.264.
    codec_profile: ?Xavc4kProfileCodecProfile,

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

    /// Optional. Use Quality tuning level to choose how you want to trade off
    /// encoding speed for output video quality. The default behavior is faster,
    /// lower quality, single-pass encoding.
    quality_tuning_level: ?Xavc4kProfileQualityTuningLevel,

    /// Number of slices per picture. Must be less than or equal to the number of
    /// macroblock rows for progressive pictures, and less than or equal to half the
    /// number of macroblock rows for interlaced pictures.
    slices: ?i32,

    pub const json_field_names = .{
        .bitrate_class = "BitrateClass",
        .codec_profile = "CodecProfile",
        .flicker_adaptive_quantization = "FlickerAdaptiveQuantization",
        .gop_b_reference = "GopBReference",
        .gop_closed_cadence = "GopClosedCadence",
        .hrd_buffer_size = "HrdBufferSize",
        .quality_tuning_level = "QualityTuningLevel",
        .slices = "Slices",
    };
};
