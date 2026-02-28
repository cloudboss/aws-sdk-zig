const TechnicalCueType = @import("technical_cue_type.zig").TechnicalCueType;

/// Information about a technical cue segment. For more information, see
/// SegmentDetection.
pub const TechnicalCueSegment = struct {
    /// The confidence that Amazon Rekognition Video has in the accuracy of the
    /// detected segment.
    confidence: ?f32,

    /// The type of the technical cue.
    @"type": ?TechnicalCueType,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .@"type" = "Type",
    };
};
