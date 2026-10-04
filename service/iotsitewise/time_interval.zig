const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// Contains a time interval with a start time and an end time. Use a time
/// interval to restrict an operation, such as a search, to a specific time
/// range.
pub const TimeInterval = struct {
    /// The end of the time interval.
    end_time: TimeInNanos,

    /// The start of the time interval.
    start_time: TimeInNanos,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
