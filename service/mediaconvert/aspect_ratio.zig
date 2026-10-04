/// An aspect ratio expressed as a fraction with numerator and denominator
/// values, reduced to lowest terms. Used for the sample (pixel) aspect ratio
/// and the display aspect ratio of a video track. For example, a 720x576
/// anamorphic track has a sample aspect ratio of 64 / 45 and a display aspect
/// ratio of 16 / 9. A video track can declare an aspect ratio in two
/// independent places, and MediaConvert reports each one where it was found
/// rather than choosing between them. The ratio declared by the container
/// appears on the video track itself, and the ratio declared by the video
/// essence appears under codecMetadata. When a file declares an aspect ratio in
/// only one of the two places, the other is null; when it declares both and
/// they disagree, you can compare them and decide which to use.
pub const AspectRatio = struct {
    /// The denominator, or bottom number, in the fractional aspect ratio. For
    /// example, for a display aspect ratio of 16 / 9, the denominator would be 9.
    denominator: ?i32 = null,

    /// The numerator, or top number, in the fractional aspect ratio. For example,
    /// for a display aspect ratio of 16 / 9, the numerator would be 16.
    numerator: ?i32 = null,

    pub const json_field_names = .{
        .denominator = "Denominator",
        .numerator = "Numerator",
    };
};
