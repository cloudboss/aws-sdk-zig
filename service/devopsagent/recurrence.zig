const DailyRecurrence = @import("daily_recurrence.zig").DailyRecurrence;
const MonthlyRecurrence = @import("monthly_recurrence.zig").MonthlyRecurrence;
const WeeklyRecurrence = @import("weekly_recurrence.zig").WeeklyRecurrence;

/// Recurrence cadence for a time-range schedule
pub const Recurrence = union(enum) {
    /// The window recurs every day
    daily: ?DailyRecurrence,
    /// The window recurs once per month
    monthly: ?MonthlyRecurrence,
    /// The window recurs once per week
    weekly: ?WeeklyRecurrence,

    pub const json_field_names = .{
        .daily = "daily",
        .monthly = "monthly",
        .weekly = "weekly",
    };
};
