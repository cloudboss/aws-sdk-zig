/// For motion overlays that don't have a built-in frame rate, specify the frame
/// rate of the overlay in frames per second, as a fraction. For example,
/// specify 24 fps as 24/1. The overlay frame rate doesn't need to match the
/// frame rate of the underlying video.
pub const MotionImageInsertionFramerate = struct {
    /// The bottom of the fraction that expresses your overlay frame rate. For
    /// example, if your frame rate is 24 fps, set this value to 1.
    framerate_denominator: ?i32 = null,

    /// The top of the fraction that expresses your overlay frame rate. For example,
    /// if your frame rate is 24 fps, set this value to 24.
    framerate_numerator: ?i32 = null,

    pub const json_field_names = .{
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
    };
};
