/// Defines a non-overlapping region of a table's partitions, allowing
/// multiple requests to be run in parallel.
pub const Segment = struct {
    /// The zero-based index number of the segment. For example, if the total number
    /// of segments
    /// is 4, `SegmentNumber` values range from 0 through 3.
    segment_number: i32 = 0,

    /// The total number of segments.
    total_segments: i32,

    pub const json_field_names = .{
        .segment_number = "SegmentNumber",
        .total_segments = "TotalSegments",
    };
};
