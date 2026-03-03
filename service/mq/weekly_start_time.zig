const DayOfWeek = @import("day_of_week.zig").DayOfWeek;

/// The scheduled time period relative to UTC during which Amazon MQ begins to
/// apply pending updates or patches to the broker.
pub const WeeklyStartTime = struct {
    /// Required. The day of the week.
    day_of_week: DayOfWeek,

    /// Required. The time, in 24-hour format.
    time_of_day: []const u8,

    /// The time zone, UTC by default, in either the Country/City format, or the UTC
    /// offset format.
    time_zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .day_of_week = "DayOfWeek",
        .time_of_day = "TimeOfDay",
        .time_zone = "TimeZone",
    };
};
