const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// Contains settings for trimming content to a specific time range.
pub const TrimSettings = struct {
    /// The end time for the trim range. Must be greater than startTime.
    end_time: TimeInNanos,

    /// The start time for the trim range.
    start_time: TimeInNanos,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
