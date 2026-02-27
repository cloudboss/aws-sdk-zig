const DayOfWeek = @import("day_of_week.zig").DayOfWeek;

/// The refresh on entity for weekly or monthly schedules.
pub const ScheduleRefreshOnEntity = struct {
    /// The day of the month that you want to schedule refresh on.
    day_of_month: ?[]const u8,

    /// The day of the week that you want to schedule a refresh on.
    day_of_week: ?DayOfWeek,

    pub const json_field_names = .{
        .day_of_month = "DayOfMonth",
        .day_of_week = "DayOfWeek",
    };
};
