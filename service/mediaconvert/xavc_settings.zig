const XavcAdaptiveQuantization = @import("xavc_adaptive_quantization.zig").XavcAdaptiveQuantization;
const XavcEntropyEncoding = @import("xavc_entropy_encoding.zig").XavcEntropyEncoding;
const XavcFramerateControl = @import("xavc_framerate_control.zig").XavcFramerateControl;
const XavcFramerateConversionAlgorithm = @import("xavc_framerate_conversion_algorithm.zig").XavcFramerateConversionAlgorithm;
const FrameMetricType = @import("frame_metric_type.zig").FrameMetricType;
const XavcProfile = @import("xavc_profile.zig").XavcProfile;
const XavcSlowPal = @import("xavc_slow_pal.zig").XavcSlowPal;
const XavcSpatialAdaptiveQuantization = @import("xavc_spatial_adaptive_quantization.zig").XavcSpatialAdaptiveQuantization;
const XavcTemporalAdaptiveQuantization = @import("xavc_temporal_adaptive_quantization.zig").XavcTemporalAdaptiveQuantization;
const Xavc4kIntraCbgProfileSettings = @import("xavc_4_k_intra_cbg_profile_settings.zig").Xavc4kIntraCbgProfileSettings;
const Xavc4kIntraVbrProfileSettings = @import("xavc_4_k_intra_vbr_profile_settings.zig").Xavc4kIntraVbrProfileSettings;
const Xavc4kProfileSettings = @import("xavc_4_k_profile_settings.zig").Xavc4kProfileSettings;
const XavcHdIntraCbgProfileSettings = @import("xavc_hd_intra_cbg_profile_settings.zig").XavcHdIntraCbgProfileSettings;
const XavcHdProfileSettings = @import("xavc_hd_profile_settings.zig").XavcHdProfileSettings;

/// Required when you set Codec to the value XAVC.
pub const XavcSettings = struct {
    /// Keep the default value, Auto, for this setting to have MediaConvert
    /// automatically apply the best types of quantization for your video content.
    /// When you want to apply your quantization settings manually, you must set
    /// Adaptive quantization to a value other than Auto. Use this setting to
    /// specify the strength of any adaptive quantization filters that you enable.
    /// If you don't want MediaConvert to do any adaptive quantization in this
    /// transcode, set Adaptive quantization to Off. Related settings: The value
    /// that you choose here applies to the following settings: Flicker adaptive
    /// quantization (flickerAdaptiveQuantization), Spatial adaptive quantization,
    /// and Temporal adaptive quantization.
    adaptive_quantization: ?XavcAdaptiveQuantization,

    /// Optional. Choose a specific entropy encoding mode only when you want to
    /// override XAVC recommendations. If you choose the value auto, MediaConvert
    /// uses the mode that the XAVC file format specifies given this output's
    /// operating point.
    entropy_encoding: ?XavcEntropyEncoding,

    /// If you are using the console, use the Frame rate setting to specify the
    /// frame rate for this output. If you want to keep the same frame rate as the
    /// input video, choose Follow source. If you want to do frame rate conversion,
    /// choose a frame rate from the dropdown list. The framerates shown in the
    /// dropdown list are decimal approximations of fractions.
    framerate_control: ?XavcFramerateControl,

    /// Choose the method that you want MediaConvert to use when increasing or
    /// decreasing your video's frame rate. For numerically simple conversions, such
    /// as 60 fps to 30 fps: We recommend that you keep the default value, Drop
    /// duplicate. For numerically complex conversions, to avoid stutter: Choose
    /// Interpolate. This results in a smooth picture, but might introduce
    /// undesirable video artifacts. For complex frame rate conversions, especially
    /// if your source video has already been converted from its original cadence:
    /// Choose FrameFormer to do motion-compensated interpolation. FrameFormer uses
    /// the best conversion method frame by frame. Note that using FrameFormer
    /// increases the transcoding time and incurs a significant add-on cost. When
    /// you choose FrameFormer, your input video resolution must be at least 128x96.
    /// To create an output with the same number of frames as your input: Choose
    /// Maintain frame count. When you do, MediaConvert will not drop, interpolate,
    /// add, or otherwise change the frame count from your input to your output.
    /// Note that since the frame count is maintained, the duration of your output
    /// will become shorter at higher frame rates and longer at lower frame rates.
    framerate_conversion_algorithm: ?XavcFramerateConversionAlgorithm,

    /// When you use the API for transcode jobs that use frame rate conversion,
    /// specify the frame rate as a fraction. For example, 24000 / 1001 = 23.976
    /// fps. Use FramerateDenominator to specify the denominator of this fraction.
    /// In this example, use 1001 for the value of FramerateDenominator. When you
    /// use the console for transcode jobs that use frame rate conversion, provide
    /// the value as a decimal number for Frame rate. In this example, specify
    /// 23.976.
    framerate_denominator: ?i32,

    /// When you use the API for transcode jobs that use frame rate conversion,
    /// specify the frame rate as a fraction. For example, 24000 / 1001 = 23.976
    /// fps. Use FramerateNumerator to specify the numerator of this fraction. In
    /// this example, use 24000 for the value of FramerateNumerator. When you use
    /// the console for transcode jobs that use frame rate conversion, provide the
    /// value as a decimal number for Framerate. In this example, specify 23.976.
    framerate_numerator: ?i32,

    /// Optionally choose one or more per frame metric reports to generate along
    /// with your output. You can use these metrics to analyze your video output
    /// according to one or more commonly used image quality metrics. You can
    /// specify per frame metrics for output groups or for individual outputs. When
    /// you do, MediaConvert writes a CSV (Comma-Separated Values) file to your S3
    /// output destination, named after the output name and metric type. For
    /// example: videofile_PSNR.csv Jobs that generate per frame metrics will take
    /// longer to complete, depending on the resolution and complexity of your
    /// output. For example, some 4K jobs might take up to twice as long to
    /// complete. Note that when analyzing the video quality of your output, or when
    /// comparing the video quality of multiple different outputs, we generally also
    /// recommend a detailed visual review in a controlled environment. You can
    /// choose from the following per frame metrics: * PSNR: Peak Signal-to-Noise
    /// Ratio * SSIM: Structural Similarity Index Measure * MS_SSIM: Multi-Scale
    /// Similarity Index Measure * PSNR_HVS: Peak Signal-to-Noise Ratio, Human
    /// Visual System * VMAF: Video Multi-Method Assessment Fusion * QVBR:
    /// Quality-Defined Variable Bitrate. This option is only available when your
    /// output uses the QVBR rate control mode. * SHOT_CHANGE: Shot Changes
    per_frame_metrics: ?[]const FrameMetricType,

    /// Specify the XAVC profile for this output. For more information, see the Sony
    /// documentation at https://www.xavc-info.org/. Note that MediaConvert doesn't
    /// support the interlaced video XAVC operating points for XAVC_HD_INTRA_CBG. To
    /// create an interlaced XAVC output, choose the profile XAVC_HD.
    profile: ?XavcProfile,

    /// Ignore this setting unless your input frame rate is 23.976 or 24 frames per
    /// second (fps). Enable slow PAL to create a 25 fps output by relabeling the
    /// video frames and resampling your audio. Note that enabling this setting will
    /// slightly reduce the duration of your video. Related settings: You must also
    /// set Frame rate to 25.
    slow_pal: ?XavcSlowPal,

    /// Ignore this setting unless your downstream workflow requires that you
    /// specify it explicitly. Otherwise, we recommend that you adjust the softness
    /// of your output by using a lower value for the setting Sharpness or by
    /// enabling a noise reducer filter. The Softness setting specifies the
    /// quantization matrices that the encoder uses. Keep the default value, 0, for
    /// flat quantization. Choose the value 1 or 16 to use the default JVT softening
    /// quantization matricies from the H.264 specification. Choose a value from 17
    /// to 128 to use planar interpolation. Increasing values from 17 to 128 result
    /// in increasing reduction of high-frequency data. The value 128 results in the
    /// softest video.
    softness: ?i32,

    /// The best way to set up adaptive quantization is to keep the default value,
    /// Auto, for the setting Adaptive quantization. When you do so, MediaConvert
    /// automatically applies the best types of quantization for your video content.
    /// Include this setting in your JSON job specification only when you choose to
    /// change the default value for Adaptive quantization. For this setting, keep
    /// the default value, Enabled, to adjust quantization within each frame based
    /// on spatial variation of content complexity. When you enable this feature,
    /// the encoder uses fewer bits on areas that can sustain more distortion with
    /// no noticeable visual degradation and uses more bits on areas where any small
    /// distortion will be noticeable. For example, complex textured blocks are
    /// encoded with fewer bits and smooth textured blocks are encoded with more
    /// bits. Enabling this feature will almost always improve your video quality.
    /// Note, though, that this feature doesn't take into account where the viewer's
    /// attention is likely to be. If viewers are likely to be focusing their
    /// attention on a part of the screen with a lot of complex texture, you might
    /// choose to disable this feature. Related setting: When you enable spatial
    /// adaptive quantization, set the value for Adaptive quantization depending on
    /// your content. For homogeneous content, such as cartoons and video games, set
    /// it to Low. For content with a wider variety of textures, set it to High or
    /// Higher.
    spatial_adaptive_quantization: ?XavcSpatialAdaptiveQuantization,

    /// The best way to set up adaptive quantization is to keep the default value,
    /// Auto, for the setting Adaptive quantization. When you do so, MediaConvert
    /// automatically applies the best types of quantization for your video content.
    /// Include this setting in your JSON job specification only when you choose to
    /// change the default value for Adaptive quantization. For this setting, keep
    /// the default value, Enabled, to adjust quantization within each frame based
    /// on temporal variation of content complexity. When you enable this feature,
    /// the encoder uses fewer bits on areas of the frame that aren't moving and
    /// uses more bits on complex objects with sharp edges that move a lot. For
    /// example, this feature improves the readability of text tickers on newscasts
    /// and scoreboards on sports matches. Enabling this feature will almost always
    /// improve your video quality. Note, though, that this feature doesn't take
    /// into account where the viewer's attention is likely to be. If viewers are
    /// likely to be focusing their attention on a part of the screen that doesn't
    /// have moving objects with sharp edges, such as sports athletes' faces, you
    /// might choose to disable this feature. Related setting: When you enable
    /// temporal adaptive quantization, adjust the strength of the filter with the
    /// setting Adaptive quantization.
    temporal_adaptive_quantization: ?XavcTemporalAdaptiveQuantization,

    /// Required when you set Profile to the value XAVC_4K_INTRA_CBG.
    xavc_4_k_intra_cbg_profile_settings: ?Xavc4kIntraCbgProfileSettings,

    /// Required when you set Profile to the value XAVC_4K_INTRA_VBR.
    xavc_4_k_intra_vbr_profile_settings: ?Xavc4kIntraVbrProfileSettings,

    /// Required when you set Profile to the value XAVC_4K.
    xavc_4_k_profile_settings: ?Xavc4kProfileSettings,

    /// Required when you set Profile to the value XAVC_HD_INTRA_CBG.
    xavc_hd_intra_cbg_profile_settings: ?XavcHdIntraCbgProfileSettings,

    /// Required when you set Profile to the value XAVC_HD.
    xavc_hd_profile_settings: ?XavcHdProfileSettings,

    pub const json_field_names = .{
        .adaptive_quantization = "AdaptiveQuantization",
        .entropy_encoding = "EntropyEncoding",
        .framerate_control = "FramerateControl",
        .framerate_conversion_algorithm = "FramerateConversionAlgorithm",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .per_frame_metrics = "PerFrameMetrics",
        .profile = "Profile",
        .slow_pal = "SlowPal",
        .softness = "Softness",
        .spatial_adaptive_quantization = "SpatialAdaptiveQuantization",
        .temporal_adaptive_quantization = "TemporalAdaptiveQuantization",
        .xavc_4_k_intra_cbg_profile_settings = "Xavc4kIntraCbgProfileSettings",
        .xavc_4_k_intra_vbr_profile_settings = "Xavc4kIntraVbrProfileSettings",
        .xavc_4_k_profile_settings = "Xavc4kProfileSettings",
        .xavc_hd_intra_cbg_profile_settings = "XavcHdIntraCbgProfileSettings",
        .xavc_hd_profile_settings = "XavcHdProfileSettings",
    };
};
