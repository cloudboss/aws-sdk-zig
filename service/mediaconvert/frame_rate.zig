/// The frame rate of the video or audio track, expressed as a fraction with
/// numerator and denominator values.
pub const FrameRate = struct {
    /// The denominator, or bottom number, in the fractional frame rate. For
    /// example, if your frame rate is 24000 / 1001 (23.976 frames per second), then
    /// the denominator would be 1001.
    denominator: ?i32,

    /// The numerator, or top number, in the fractional frame rate. For example, if
    /// your frame rate is 24000 / 1001 (23.976 frames per second), then the
    /// numerator would be 24000.
    numerator: ?i32,

    pub const json_field_names = .{
        .denominator = "Denominator",
        .numerator = "Numerator",
    };
};
