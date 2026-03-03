const SegmentType = @import("segment_type.zig").SegmentType;

/// Information about the type of a segment requested in a call to
/// StartSegmentDetection.
/// An array of `SegmentTypeInfo` objects is returned by the response from
/// GetSegmentDetection.
pub const SegmentTypeInfo = struct {
    /// The version of the model used to detect segments.
    model_version: ?[]const u8 = null,

    /// The type of a segment (technical cue or shot detection).
    @"type": ?SegmentType = null,

    pub const json_field_names = .{
        .model_version = "ModelVersion",
        .@"type" = "Type",
    };
};
