const UncompressedFourcc = @import("uncompressed_fourcc.zig").UncompressedFourcc;
const UncompressedFramerateControl = @import("uncompressed_framerate_control.zig").UncompressedFramerateControl;
const UncompressedFramerateConversionAlgorithm = @import("uncompressed_framerate_conversion_algorithm.zig").UncompressedFramerateConversionAlgorithm;
const UncompressedInterlaceMode = @import("uncompressed_interlace_mode.zig").UncompressedInterlaceMode;
const UncompressedScanTypeConversionMode = @import("uncompressed_scan_type_conversion_mode.zig").UncompressedScanTypeConversionMode;
const UncompressedSlowPal = @import("uncompressed_slow_pal.zig").UncompressedSlowPal;
const UncompressedTelecine = @import("uncompressed_telecine.zig").UncompressedTelecine;

/// Required when you set Codec, under VideoDescription>CodecSettings to the
/// value UNCOMPRESSED.
pub const UncompressedSettings = struct {
    /// The four character code for the uncompressed video.
    fourcc: ?UncompressedFourcc,

    /// Use the Framerate setting to specify the frame rate for this output. If you
    /// want to keep the same frame rate as the input video, choose Follow source.
    /// If you want to do frame rate conversion, choose a frame rate from the
    /// dropdown list or choose Custom. The framerates shown in the dropdown list
    /// are decimal approximations of fractions. If you choose Custom, specify your
    /// frame rate as a fraction.
    framerate_control: ?UncompressedFramerateControl,

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
    framerate_conversion_algorithm: ?UncompressedFramerateConversionAlgorithm,

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

    /// Optional. Choose the scan line type for this output. If you don't specify a
    /// value, MediaConvert will create a progressive output.
    interlace_mode: ?UncompressedInterlaceMode,

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
    scan_type_conversion_mode: ?UncompressedScanTypeConversionMode,

    /// Ignore this setting unless your input frame rate is 23.976 or 24 frames per
    /// second (fps). Enable slow PAL to create a 25 fps output by relabeling the
    /// video frames and resampling your audio. Note that enabling this setting will
    /// slightly reduce the duration of your video. Related settings: You must also
    /// set Framerate to 25.
    slow_pal: ?UncompressedSlowPal,

    /// When you do frame rate conversion from 23.976 frames per second (fps) to
    /// 29.97 fps, and your output scan type is interlaced, you can optionally
    /// enable hard telecine to create a smoother picture. When you keep the default
    /// value, None, MediaConvert does a standard frame rate conversion to 29.97
    /// without doing anything with the field polarity to create a smoother picture.
    telecine: ?UncompressedTelecine,

    pub const json_field_names = .{
        .fourcc = "Fourcc",
        .framerate_control = "FramerateControl",
        .framerate_conversion_algorithm = "FramerateConversionAlgorithm",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .interlace_mode = "InterlaceMode",
        .scan_type_conversion_mode = "ScanTypeConversionMode",
        .slow_pal = "SlowPal",
        .telecine = "Telecine",
    };
};
