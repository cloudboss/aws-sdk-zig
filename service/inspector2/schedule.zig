const DailySchedule = @import("daily_schedule.zig").DailySchedule;
const MonthlySchedule = @import("monthly_schedule.zig").MonthlySchedule;
const OneTimeSchedule = @import("one_time_schedule.zig").OneTimeSchedule;
const WeeklySchedule = @import("weekly_schedule.zig").WeeklySchedule;

/// A schedule.
pub const Schedule = union(enum) {
    /// The schedule's daily.
    daily: ?DailySchedule,
    /// The schedule's monthly.
    monthly: ?MonthlySchedule,
    /// The schedule's one time.
    one_time: ?OneTimeSchedule,
    /// The schedule's weekly.
    weekly: ?WeeklySchedule,

    pub const json_field_names = .{
        .daily = "daily",
        .monthly = "monthly",
        .one_time = "oneTime",
        .weekly = "weekly",
    };
};
