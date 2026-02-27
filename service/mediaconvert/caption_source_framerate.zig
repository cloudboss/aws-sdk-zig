/// Ignore this setting unless your input captions format is SCC. To have the
/// service compensate for differing frame rates between your input captions and
/// input video, specify the frame rate of the captions file. Specify this value
/// as a fraction. For example, you might specify 24 / 1 for 24 fps, 25 / 1 for
/// 25 fps, 24000 / 1001 for 23.976 fps, or 30000 / 1001 for 29.97 fps.
pub const CaptionSourceFramerate = struct {
    /// Specify the denominator of the fraction that represents the frame rate for
    /// the setting Caption source frame rate. Use this setting along with the
    /// setting Framerate numerator.
    framerate_denominator: ?i32,

    /// Specify the numerator of the fraction that represents the frame rate for the
    /// setting Caption source frame rate. Use this setting along with the setting
    /// Framerate denominator.
    framerate_numerator: ?i32,

    pub const json_field_names = .{
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
    };
};
