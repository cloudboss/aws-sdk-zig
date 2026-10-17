/// Monthly recurrence
pub const MonthlyRecurrence = struct {
    /// Day of month the window recurs on
    day_of_month: i32,

    pub const json_field_names = .{
        .day_of_month = "dayOfMonth",
    };
};
