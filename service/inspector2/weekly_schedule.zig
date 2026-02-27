const Day = @import("day.zig").Day;
const Time = @import("time.zig").Time;

/// A weekly schedule.
pub const WeeklySchedule = struct {
    /// The weekly schedule's days.
    days: []const Day,

    /// The weekly schedule's start time.
    start_time: Time,

    pub const json_field_names = .{
        .days = "days",
        .start_time = "startTime",
    };
};
