const Vp8FramerateControl = @import("vp_8_framerate_control.zig").Vp8FramerateControl;
const Vp8FramerateConversionAlgorithm = @import("vp_8_framerate_conversion_algorithm.zig").Vp8FramerateConversionAlgorithm;
const Vp8ParControl = @import("vp_8_par_control.zig").Vp8ParControl;
const Vp8QualityTuningLevel = @import("vp_8_quality_tuning_level.zig").Vp8QualityTuningLevel;
const Vp8RateControlMode = @import("vp_8_rate_control_mode.zig").Vp8RateControlMode;

/// Required when you set Codec to the value VP8.
pub const Vp8Settings = struct {
    /// Target bitrate in bits/second. For example, enter five megabits per second
    /// as 5000000.
    bitrate: ?i32,

    /// If you are using the console, use the Framerate setting to specify the frame
    /// rate for this output. If you want to keep the same frame rate as the input
    /// video, choose Follow source. If you want to do frame rate conversion, choose
    /// a frame rate from the dropdown list or choose Custom. The framerates shown
    /// in the dropdown list are decimal approximations of fractions. If you choose
    /// Custom, specify your frame rate as a fraction.
    framerate_control: ?Vp8FramerateControl,

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
    framerate_conversion_algorithm: ?Vp8FramerateConversionAlgorithm,

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

    /// GOP Length (keyframe interval) in frames. Must be greater than zero.
    gop_size: ?f64,

    /// Optional. Size of buffer (HRD buffer model) in bits. For example, enter five
    /// megabits as 5000000.
    hrd_buffer_size: ?i32,

    /// Ignore this setting unless you set qualityTuningLevel to MULTI_PASS.
    /// Optional. Specify the maximum bitrate in bits/second. For example, enter
    /// five megabits per second as 5000000. The default behavior uses twice the
    /// target bitrate as the maximum bitrate.
    max_bitrate: ?i32,

    /// Optional. Specify how the service determines the pixel aspect ratio (PAR)
    /// for this output. The default behavior, Follow source, uses the PAR from your
    /// input video for your output. To specify a different PAR in the console,
    /// choose any value other than Follow source. When you choose SPECIFIED for
    /// this setting, you must also specify values for the parNumerator and
    /// parDenominator settings.
    par_control: ?Vp8ParControl,

    /// Required when you set Pixel aspect ratio to SPECIFIED. On the console, this
    /// corresponds to any value other than Follow source. When you specify an
    /// output pixel aspect ratio (PAR) that is different from your input video PAR,
    /// provide your output PAR as a ratio. For example, for D1/DV NTSC widescreen,
    /// you would specify the ratio 40:33. In this example, the value for
    /// parDenominator is 33.
    par_denominator: ?i32,

    /// Required when you set Pixel aspect ratio to SPECIFIED. On the console, this
    /// corresponds to any value other than Follow source. When you specify an
    /// output pixel aspect ratio (PAR) that is different from your input video PAR,
    /// provide your output PAR as a ratio. For example, for D1/DV NTSC widescreen,
    /// you would specify the ratio 40:33. In this example, the value for
    /// parNumerator is 40.
    par_numerator: ?i32,

    /// Optional. Use Quality tuning level to choose how you want to trade off
    /// encoding speed for output video quality. The default behavior is faster,
    /// lower quality, multi-pass encoding.
    quality_tuning_level: ?Vp8QualityTuningLevel,

    /// With the VP8 codec, you can use only the variable bitrate (VBR) rate control
    /// mode.
    rate_control_mode: ?Vp8RateControlMode,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .framerate_control = "FramerateControl",
        .framerate_conversion_algorithm = "FramerateConversionAlgorithm",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .gop_size = "GopSize",
        .hrd_buffer_size = "HrdBufferSize",
        .max_bitrate = "MaxBitrate",
        .par_control = "ParControl",
        .par_denominator = "ParDenominator",
        .par_numerator = "ParNumerator",
        .quality_tuning_level = "QualityTuningLevel",
        .rate_control_mode = "RateControlMode",
    };
};
