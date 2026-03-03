const Vc3FramerateControl = @import("vc_3_framerate_control.zig").Vc3FramerateControl;
const Vc3FramerateConversionAlgorithm = @import("vc_3_framerate_conversion_algorithm.zig").Vc3FramerateConversionAlgorithm;
const Vc3InterlaceMode = @import("vc_3_interlace_mode.zig").Vc3InterlaceMode;
const Vc3ScanTypeConversionMode = @import("vc_3_scan_type_conversion_mode.zig").Vc3ScanTypeConversionMode;
const Vc3SlowPal = @import("vc_3_slow_pal.zig").Vc3SlowPal;
const Vc3Telecine = @import("vc_3_telecine.zig").Vc3Telecine;
const Vc3Class = @import("vc_3_class.zig").Vc3Class;

/// Required when you set Codec to the value VC3
pub const Vc3Settings = struct {
    /// If you are using the console, use the Framerate setting to specify the frame
    /// rate for this output. If you want to keep the same frame rate as the input
    /// video, choose Follow source. If you want to do frame rate conversion, choose
    /// a frame rate from the dropdown list or choose Custom. The framerates shown
    /// in the dropdown list are decimal approximations of fractions. If you choose
    /// Custom, specify your frame rate as a fraction.
    framerate_control: ?Vc3FramerateControl = null,

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
    framerate_conversion_algorithm: ?Vc3FramerateConversionAlgorithm = null,

    /// When you use the API for transcode jobs that use frame rate conversion,
    /// specify the frame rate as a fraction. For example, 24000 / 1001 = 23.976
    /// fps. Use FramerateDenominator to specify the denominator of this fraction.
    /// In this example, use 1001 for the value of FramerateDenominator. When you
    /// use the console for transcode jobs that use frame rate conversion, provide
    /// the value as a decimal number for Framerate. In this example, specify
    /// 23.976.
    framerate_denominator: ?i32 = null,

    /// When you use the API for transcode jobs that use frame rate conversion,
    /// specify the frame rate as a fraction. For example, 24000 / 1001 = 23.976
    /// fps. Use FramerateNumerator to specify the numerator of this fraction. In
    /// this example, use 24000 for the value of FramerateNumerator. When you use
    /// the console for transcode jobs that use frame rate conversion, provide the
    /// value as a decimal number for Framerate. In this example, specify 23.976.
    framerate_numerator: ?i32 = null,

    /// Optional. Choose the scan line type for this output. If you don't specify a
    /// value, MediaConvert will create a progressive output.
    interlace_mode: ?Vc3InterlaceMode = null,

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
    scan_type_conversion_mode: ?Vc3ScanTypeConversionMode = null,

    /// Ignore this setting unless your input frame rate is 23.976 or 24 frames per
    /// second (fps). Enable slow PAL to create a 25 fps output by relabeling the
    /// video frames and resampling your audio. Note that enabling this setting will
    /// slightly reduce the duration of your video. Related settings: You must also
    /// set Framerate to 25.
    slow_pal: ?Vc3SlowPal = null,

    /// When you do frame rate conversion from 23.976 frames per second (fps) to
    /// 29.97 fps, and your output scan type is interlaced, you can optionally
    /// enable hard telecine to create a smoother picture. When you keep the default
    /// value, None, MediaConvert does a standard frame rate conversion to 29.97
    /// without doing anything with the field polarity to create a smoother picture.
    telecine: ?Vc3Telecine = null,

    /// Specify the VC3 class to choose the quality characteristics for this output.
    /// VC3 class, together with the settings Framerate (framerateNumerator and
    /// framerateDenominator) and Resolution (height and width), determine your
    /// output bitrate. For example, say that your video resolution is 1920x1080 and
    /// your framerate is 29.97. Then Class 145 gives you an output with a bitrate
    /// of approximately 145 Mbps and Class 220 gives you and output with a bitrate
    /// of approximately 220 Mbps. VC3 class also specifies the color bit depth of
    /// your output.
    vc_3_class: ?Vc3Class = null,

    pub const json_field_names = .{
        .framerate_control = "FramerateControl",
        .framerate_conversion_algorithm = "FramerateConversionAlgorithm",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .interlace_mode = "InterlaceMode",
        .scan_type_conversion_mode = "ScanTypeConversionMode",
        .slow_pal = "SlowPal",
        .telecine = "Telecine",
        .vc_3_class = "Vc3Class",
    };
};
