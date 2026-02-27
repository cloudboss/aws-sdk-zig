const TimestampRange = @import("timestamp_range.zig").TimestampRange;

/// Contains the timestamps of matched categories.
pub const PointsOfInterest = struct {
    /// Contains the timestamp ranges (start time through end time) of matched
    /// categories and rules.
    timestamp_ranges: ?[]const TimestampRange,

    pub const json_field_names = .{
        .timestamp_ranges = "TimestampRanges",
    };
};
