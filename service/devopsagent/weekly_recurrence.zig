const DayOfWeek = @import("day_of_week.zig").DayOfWeek;

/// Weekly recurrence
pub const WeeklyRecurrence = struct {
    /// Day of week the window recurs on
    day_of_week: DayOfWeek,

    pub const json_field_names = .{
        .day_of_week = "dayOfWeek",
    };
};
