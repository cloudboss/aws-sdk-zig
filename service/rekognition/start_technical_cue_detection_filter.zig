const BlackFrame = @import("black_frame.zig").BlackFrame;

/// Filters for the technical segments returned by GetSegmentDetection. For more
/// information,
/// see StartSegmentDetectionFilters.
pub const StartTechnicalCueDetectionFilter = struct {
    /// A filter that allows you to control the black frame detection by specifying
    /// the black levels and pixel coverage of black pixels in a frame.
    /// Videos can come from multiple sources, formats, and time periods, with
    /// different standards and varying noise levels for black frames that need to
    /// be accounted for.
    black_frame: ?BlackFrame = null,

    /// Specifies the minimum confidence that Amazon Rekognition Video must have in
    /// order to return a detected segment. Confidence
    /// represents how certain Amazon Rekognition is that a segment is correctly
    /// identified. 0 is the lowest confidence.
    /// 100 is the highest confidence. Amazon Rekognition Video doesn't return any
    /// segments with a confidence level
    /// lower than this specified value.
    ///
    /// If you don't specify `MinSegmentConfidence`, `GetSegmentDetection` returns
    /// segments with confidence values greater than or equal to 50 percent.
    min_segment_confidence: ?f32 = null,

    pub const json_field_names = .{
        .black_frame = "BlackFrame",
        .min_segment_confidence = "MinSegmentConfidence",
    };
};
