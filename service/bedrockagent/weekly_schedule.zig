const DayOfWeek = @import("day_of_week.zig").DayOfWeek;

/// A weekly sync on a specified day of the week.
pub const WeeklySchedule = struct {
    /// The day of the week on which the weekly sync runs.
    day_of_week: DayOfWeek,

    pub const json_field_names = .{
        .day_of_week = "dayOfWeek",
    };
};
