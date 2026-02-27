const AvcIntraClass = @import("avc_intra_class.zig").AvcIntraClass;
const AvcIntraUhdSettings = @import("avc_intra_uhd_settings.zig").AvcIntraUhdSettings;
const AvcIntraFramerateControl = @import("avc_intra_framerate_control.zig").AvcIntraFramerateControl;
const AvcIntraFramerateConversionAlgorithm = @import("avc_intra_framerate_conversion_algorithm.zig").AvcIntraFramerateConversionAlgorithm;
const AvcIntraInterlaceMode = @import("avc_intra_interlace_mode.zig").AvcIntraInterlaceMode;
const FrameMetricType = @import("frame_metric_type.zig").FrameMetricType;
const AvcIntraScanTypeConversionMode = @import("avc_intra_scan_type_conversion_mode.zig").AvcIntraScanTypeConversionMode;
const AvcIntraSlowPal = @import("avc_intra_slow_pal.zig").AvcIntraSlowPal;
const AvcIntraTelecine = @import("avc_intra_telecine.zig").AvcIntraTelecine;

/// Required when you choose AVC-Intra for your output video codec. For more
/// information about the AVC-Intra settings, see the relevant specification.
/// For detailed information about SD and HD in AVC-Intra, see
/// https://ieeexplore.ieee.org/document/7290936. For information about 4K/2K in
/// AVC-Intra, see
/// https://pro-av.panasonic.net/en/avc-ultra/AVC-ULTRAoverview.pdf.
pub const AvcIntraSettings = struct {
    /// Specify the AVC-Intra class of your output. The AVC-Intra class selection
    /// determines the output video bit rate depending on the frame rate of the
    /// output. Outputs with higher class values have higher bitrates and improved
    /// image quality. Note that for Class 4K/2K, MediaConvert supports only 4:2:2
    /// chroma subsampling.
    avc_intra_class: ?AvcIntraClass,

    /// Optional when you set AVC-Intra class to Class 4K/2K. When you set AVC-Intra
    /// class to a different value, this object isn't allowed.
    avc_intra_uhd_settings: ?AvcIntraUhdSettings,

    /// If you are using the console, use the Framerate setting to specify the frame
    /// rate for this output. If you want to keep the same frame rate as the input
    /// video, choose Follow source. If you want to do frame rate conversion, choose
    /// a frame rate from the dropdown list or choose Custom. The framerates shown
    /// in the dropdown list are decimal approximations of fractions. If you choose
    /// Custom, specify your frame rate as a fraction.
    framerate_control: ?AvcIntraFramerateControl,

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
    framerate_conversion_algorithm: ?AvcIntraFramerateConversionAlgorithm,

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
    interlace_mode: ?AvcIntraInterlaceMode,

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

    /// Use this setting for interlaced outputs, when your output frame rate is half
    /// of your input frame rate. In this situation, choose Optimized interlacing to
    /// create a better quality interlaced output. In this case, each progressive
    /// frame from the input corresponds to an interlaced field in the output. Keep
    /// the default value, Basic interlacing, for all other output frame rates. With
    /// basic interlacing, MediaConvert performs any frame rate conversion first and
    /// then interlaces the frames. When you choose Optimized interlacing and you
    /// set your output frame rate to a value that isn't suitable for optimized
    /// interlacing, MediaConvert automatically falls back to basic interlacing.
    /// Required settings: To use optimized interlacing, you must set Telecine to
    /// None or Soft. You can't use optimized interlacing for hard telecine outputs.
    /// You must also set Interlace mode to a value other than Progressive.
    scan_type_conversion_mode: ?AvcIntraScanTypeConversionMode,

    /// Ignore this setting unless your input frame rate is 23.976 or 24 frames per
    /// second (fps). Enable slow PAL to create a 25 fps output. When you enable
    /// slow PAL, MediaConvert relabels the video frames to 25 fps and resamples
    /// your audio to keep it synchronized with the video. Note that enabling this
    /// setting will slightly reduce the duration of your video. Required settings:
    /// You must also set Framerate to 25.
    slow_pal: ?AvcIntraSlowPal,

    /// When you do frame rate conversion from 23.976 frames per second (fps) to
    /// 29.97 fps, and your output scan type is interlaced, you can optionally
    /// enable hard telecine to create a smoother picture. When you keep the default
    /// value, None, MediaConvert does a standard frame rate conversion to 29.97
    /// without doing anything with the field polarity to create a smoother picture.
    telecine: ?AvcIntraTelecine,

    pub const json_field_names = .{
        .avc_intra_class = "AvcIntraClass",
        .avc_intra_uhd_settings = "AvcIntraUhdSettings",
        .framerate_control = "FramerateControl",
        .framerate_conversion_algorithm = "FramerateConversionAlgorithm",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .interlace_mode = "InterlaceMode",
        .per_frame_metrics = "PerFrameMetrics",
        .scan_type_conversion_mode = "ScanTypeConversionMode",
        .slow_pal = "SlowPal",
        .telecine = "Telecine",
    };
};
