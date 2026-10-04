const LastDayOfMonth = @import("last_day_of_month.zig").LastDayOfMonth;

/// The day of the month on which a monthly sync runs. Specify exactly one of
/// `dayNumber` or `lastDayOfMonth`.
pub const DayOfMonth = union(enum) {
    /// A specific day of the month, from 1 to 28. Values are capped at 28, so a
    /// monthly sync runs in every month, including February.
    day_number: ?i32,
    /// Set this option to run the monthly sync on the last calendar day of each
    /// month.
    last_day_of_month: ?LastDayOfMonth,

    pub const json_field_names = .{
        .day_number = "dayNumber",
        .last_day_of_month = "lastDayOfMonth",
    };
};
