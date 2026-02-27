const Av1AdaptiveQuantization = @import("av_1_adaptive_quantization.zig").Av1AdaptiveQuantization;
const Av1BitDepth = @import("av_1_bit_depth.zig").Av1BitDepth;
const Av1FilmGrainSynthesis = @import("av_1_film_grain_synthesis.zig").Av1FilmGrainSynthesis;
const Av1FramerateControl = @import("av_1_framerate_control.zig").Av1FramerateControl;
const Av1FramerateConversionAlgorithm = @import("av_1_framerate_conversion_algorithm.zig").Av1FramerateConversionAlgorithm;
const FrameMetricType = @import("frame_metric_type.zig").FrameMetricType;
const Av1QvbrSettings = @import("av_1_qvbr_settings.zig").Av1QvbrSettings;
const Av1RateControlMode = @import("av_1_rate_control_mode.zig").Av1RateControlMode;
const Av1SpatialAdaptiveQuantization = @import("av_1_spatial_adaptive_quantization.zig").Av1SpatialAdaptiveQuantization;

/// Required when you set Codec, under VideoDescription>CodecSettings to the
/// value AV1.
pub const Av1Settings = struct {
    /// Specify the strength of any adaptive quantization filters that you enable.
    /// The value that you choose here applies to Spatial adaptive quantization.
    adaptive_quantization: ?Av1AdaptiveQuantization,

    /// Specify the Bit depth. You can choose 8-bit or 10-bit.
    bit_depth: ?Av1BitDepth,

    /// Film grain synthesis replaces film grain present in your content with
    /// similar quality synthesized AV1 film grain. We recommend that you choose
    /// Enabled to reduce the bandwidth of your QVBR quality level 5, 6, 7, or 8
    /// outputs. For QVBR quality level 9 or 10 outputs we recommend that you keep
    /// the default value, Disabled. When you include Film grain synthesis, you
    /// cannot include the Noise reducer preprocessor.
    film_grain_synthesis: ?Av1FilmGrainSynthesis,

    /// Use the Framerate setting to specify the frame rate for this output. If you
    /// want to keep the same frame rate as the input video, choose Follow source.
    /// If you want to do frame rate conversion, choose a frame rate from the
    /// dropdown list or choose Custom. The framerates shown in the dropdown list
    /// are decimal approximations of fractions. If you choose Custom, specify your
    /// frame rate as a fraction.
    framerate_control: ?Av1FramerateControl,

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
    framerate_conversion_algorithm: ?Av1FramerateConversionAlgorithm,

    /// When you use the API for transcode jobs that use frame rate conversion,
    /// specify the frame rate as a fraction. For example, 24000 / 1001 = 23.976
    /// fps. Use FramerateDenominator to specify the denominator of this fraction.
    /// In this example, use 1001 for the value of FramerateDenominator. When you
    /// use the console for transcode jobs that use frame rate conversion, provide
    /// the value as a decimal number for Framerate. In this example, specify
    /// 23.976.
    framerate_denominator: ?i32,

    /// When you use the API for transcode jobs that use frame rate conversion,
    /// specify the frame rate as a fraction. For example, 24000 / 1001 = 23.976
    /// fps. Use FramerateNumerator to specify the numerator of this fraction. In
    /// this example, use 24000 for the value of FramerateNumerator. When you use
    /// the console for transcode jobs that use frame rate conversion, provide the
    /// value as a decimal number for Framerate. In this example, specify 23.976.
    framerate_numerator: ?i32,

    /// Specify the GOP length (keyframe interval) in frames. With AV1, MediaConvert
    /// doesn't support GOP length in seconds. This value must be greater than zero
    /// and preferably equal to 1 + ((numberBFrames + 1) * x), where x is an integer
    /// value.
    gop_size: ?f64,

    /// Maximum bitrate in bits/second. For example, enter five megabits per second
    /// as 5000000. Required when Rate control mode is QVBR.
    max_bitrate: ?i32,

    /// Specify from the number of B-frames, in the range of 0-15. For AV1 encoding,
    /// we recommend using 7 or 15. Choose a larger number for a lower bitrate and
    /// smaller file size; choose a smaller number for better video quality.
    number_b_frames_between_reference_frames: ?i32,

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

    /// Settings for quality-defined variable bitrate encoding with the H.265 codec.
    /// Use these settings only when you set QVBR for Rate control mode.
    qvbr_settings: ?Av1QvbrSettings,

    /// 'With AV1 outputs, for rate control mode, MediaConvert supports only
    /// quality-defined variable bitrate (QVBR). You can''t use CBR or VBR.'
    rate_control_mode: ?Av1RateControlMode,

    /// Specify the number of slices per picture. This value must be 1, 2, 4, 8, 16,
    /// or 32. For progressive pictures, this value must be less than or equal to
    /// the number of macroblock rows. For interlaced pictures, this value must be
    /// less than or equal to half the number of macroblock rows.
    slices: ?i32,

    /// Keep the default value, Enabled, to adjust quantization within each frame
    /// based on spatial variation of content complexity. When you enable this
    /// feature, the encoder uses fewer bits on areas that can sustain more
    /// distortion with no noticeable visual degradation and uses more bits on areas
    /// where any small distortion will be noticeable. For example, complex textured
    /// blocks are encoded with fewer bits and smooth textured blocks are encoded
    /// with more bits. Enabling this feature will almost always improve your video
    /// quality. Note, though, that this feature doesn't take into account where the
    /// viewer's attention is likely to be. If viewers are likely to be focusing
    /// their attention on a part of the screen with a lot of complex texture, you
    /// might choose to disable this feature. Related setting: When you enable
    /// spatial adaptive quantization, set the value for Adaptive quantization
    /// depending on your content. For homogeneous content, such as cartoons and
    /// video games, set it to Low. For content with a wider variety of textures,
    /// set it to High or Higher.
    spatial_adaptive_quantization: ?Av1SpatialAdaptiveQuantization,

    pub const json_field_names = .{
        .adaptive_quantization = "AdaptiveQuantization",
        .bit_depth = "BitDepth",
        .film_grain_synthesis = "FilmGrainSynthesis",
        .framerate_control = "FramerateControl",
        .framerate_conversion_algorithm = "FramerateConversionAlgorithm",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .gop_size = "GopSize",
        .max_bitrate = "MaxBitrate",
        .number_b_frames_between_reference_frames = "NumberBFramesBetweenReferenceFrames",
        .per_frame_metrics = "PerFrameMetrics",
        .qvbr_settings = "QvbrSettings",
        .rate_control_mode = "RateControlMode",
        .slices = "Slices",
        .spatial_adaptive_quantization = "SpatialAdaptiveQuantization",
    };
};
