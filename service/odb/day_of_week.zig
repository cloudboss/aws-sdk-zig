const DayOfWeekName = @import("day_of_week_name.zig").DayOfWeekName;

/// An enumeration of days of the week used for scheduling maintenance windows.
pub const DayOfWeek = struct {
    /// The name of the day of the week.
    name: ?DayOfWeekName,

    pub const json_field_names = .{
        .name = "name",
    };
};
