const TimestampSegment = @import("timestamp_segment.zig").TimestampSegment;

/// Delimits the segment of the input that will be processed
pub const VideoSegmentConfiguration = union(enum) {
    /// Timestamp segment
    timestamp_segment: ?TimestampSegment,

    pub const json_field_names = .{
        .timestamp_segment = "timestampSegment",
    };
};
