const DayOfWeek = @import("day_of_week.zig").DayOfWeek;

/// Hours of entry.
pub const WaypointOptimizationAccessHoursEntry = struct {
    /// Day of the week.
    day_of_week: DayOfWeek,

    /// Time of the day.
    time_of_day: []const u8,

    pub const json_field_names = .{
        .day_of_week = "DayOfWeek",
        .time_of_day = "TimeOfDay",
    };
};
