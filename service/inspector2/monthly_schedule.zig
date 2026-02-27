const Day = @import("day.zig").Day;
const Time = @import("time.zig").Time;

/// A monthly schedule.
pub const MonthlySchedule = struct {
    /// The monthly schedule's day.
    day: Day,

    /// The monthly schedule's start time.
    start_time: Time,

    pub const json_field_names = .{
        .day = "day",
        .start_time = "startTime",
    };
};
