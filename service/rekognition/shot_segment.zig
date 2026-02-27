/// Information about a shot detection segment detected in a video. For more
/// information,
/// see SegmentDetection.
pub const ShotSegment = struct {
    /// The confidence that Amazon Rekognition Video has in the accuracy of the
    /// detected segment.
    confidence: ?f32,

    /// An Identifier for a shot detection segment detected in a video.
    index: ?i64,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .index = "Index",
    };
};
