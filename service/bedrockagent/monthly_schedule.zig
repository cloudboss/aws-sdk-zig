const DayOfMonth = @import("day_of_month.zig").DayOfMonth;

/// A monthly sync on a specified day of the month.
pub const MonthlySchedule = struct {
    /// The day of the month on which the monthly sync runs.
    day_of_month: DayOfMonth,

    pub const json_field_names = .{
        .day_of_month = "dayOfMonth",
    };
};
