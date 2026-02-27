const GifFramerateControl = @import("gif_framerate_control.zig").GifFramerateControl;
const GifFramerateConversionAlgorithm = @import("gif_framerate_conversion_algorithm.zig").GifFramerateConversionAlgorithm;

/// Required when you set (Codec) under (VideoDescription)>(CodecSettings) to
/// the value GIF
pub const GifSettings = struct {
    /// If you are using the console, use the Framerate setting to specify the frame
    /// rate for this output. If you want to keep the same frame rate as the input
    /// video, choose Follow source. If you want to do frame rate conversion, choose
    /// a frame rate from the dropdown list or choose Custom. The framerates shown
    /// in the dropdown list are decimal approximations of fractions. If you choose
    /// Custom, specify your frame rate as a fraction. If you are creating your
    /// transcoding job specification as a JSON file without the console, use
    /// FramerateControl to specify which value the service uses for the frame rate
    /// for this output. Choose INITIALIZE_FROM_SOURCE if you want the service to
    /// use the frame rate from the input. Choose SPECIFIED if you want the service
    /// to use the frame rate you specify in the settings FramerateNumerator and
    /// FramerateDenominator.
    framerate_control: ?GifFramerateControl,

    /// Optional. Specify how the transcoder performs framerate conversion. The
    /// default behavior is to use Drop duplicate (DUPLICATE_DROP) conversion. When
    /// you choose Interpolate (INTERPOLATE) instead, the conversion produces
    /// smoother motion.
    framerate_conversion_algorithm: ?GifFramerateConversionAlgorithm,

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

    pub const json_field_names = .{
        .framerate_control = "FramerateControl",
        .framerate_conversion_algorithm = "FramerateConversionAlgorithm",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
    };
};
