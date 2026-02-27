/// Specifies a segment to associate with an activity in a journey.
pub const SegmentCondition = struct {
    /// The unique identifier for the segment to associate with the activity.
    segment_id: []const u8,

    pub const json_field_names = .{
        .segment_id = "SegmentId",
    };
};
