const WeekDay = @import("week_day.zig").WeekDay;

/// The start day and time and the end day and time of the time range, in UTC.
pub const InstanceEventWindowTimeRange = struct {
    /// The hour when the time range ends.
    end_hour: ?i32,

    /// The day on which the time range ends.
    end_week_day: ?WeekDay,

    /// The hour when the time range begins.
    start_hour: ?i32,

    /// The day on which the time range begins.
    start_week_day: ?WeekDay,
};
