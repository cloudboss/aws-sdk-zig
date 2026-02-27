/// When you include Video generator, MediaConvert creates a video input with
/// black frames. Use this setting if you do not have a video input or if you
/// want to add black video frames before, or after, other inputs. You can
/// specify Video generator, or you can specify an Input file, but you cannot
/// specify both. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/video-generator.html
pub const InputVideoGenerator = struct {
    /// Specify the number of audio channels to include in your video generator
    /// input. MediaConvert creates these audio channels as silent audio within a
    /// single audio track. Enter an integer from 1 to 32.
    channels: ?i32,

    /// Specify the duration, in milliseconds, for your video generator input.
    /// Enter an integer from 1 to 86400000.
    duration: ?i32,

    /// Specify the denominator of the fraction that represents the frame rate for
    /// your video generator input. When you do, you must also specify a value for
    /// Frame rate numerator. MediaConvert uses a default frame rate of 29.97 when
    /// you leave Frame rate numerator and Frame rate denominator blank.
    framerate_denominator: ?i32,

    /// Specify the numerator of the fraction that represents the frame rate for
    /// your video generator input. When you do, you must also specify a value for
    /// Frame rate denominator. MediaConvert uses a default frame rate of 29.97 when
    /// you leave Frame rate numerator and Frame rate denominator blank.
    framerate_numerator: ?i32,

    /// Specify the height, in pixels, for your video generator input. This is
    /// useful for positioning when you include one or more video overlays for this
    /// input. To use the default resolution 540x360: Leave both width and height
    /// blank. To specify a height: Enter an even integer from 32 to 8192. When you
    /// do, you must also specify a value for width.
    height: ?i32,

    /// Specify the HTTP, HTTPS, or Amazon S3 location of the image that you want to
    /// overlay on the video. Use a PNG or TGA file.
    image_input: ?[]const u8,

    /// Specify the audio sample rate, in Hz, for the silent audio in your video
    /// generator input.
    /// Enter an integer from 32000 to 48000.
    sample_rate: ?i32,

    /// Specify the width, in pixels, for your video generator input. This is useful
    /// for positioning when you include one or more video overlays for this input.
    /// To use the default resolution 540x360: Leave both width and height blank. To
    /// specify a width: Enter an even integer from 32 to 8192. When you do, you
    /// must also specify a value for height.
    width: ?i32,

    pub const json_field_names = .{
        .channels = "Channels",
        .duration = "Duration",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .height = "Height",
        .image_input = "ImageInput",
        .sample_rate = "SampleRate",
        .width = "Width",
    };
};
