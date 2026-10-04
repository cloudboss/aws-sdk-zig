const DailySchedule = @import("daily_schedule.zig").DailySchedule;
const MonthlySchedule = @import("monthly_schedule.zig").MonthlySchedule;
const WeeklySchedule = @import("weekly_schedule.zig").WeeklySchedule;

/// The recurring schedule on which a managed knowledge base connector
/// automatically syncs its data source. Specify exactly one of `daily`,
/// `weekly`, or `monthly`.
pub const SyncSchedule = union(enum) {
    /// A daily sync that runs once a day at a system-chosen off-peak time. The run
    /// time is not configurable.
    daily: ?DailySchedule,
    /// A monthly sync that runs once a month on the specified day of the month.
    monthly: ?MonthlySchedule,
    /// A weekly sync that runs once a week on the specified day of the week.
    weekly: ?WeeklySchedule,

    pub const json_field_names = .{
        .daily = "daily",
        .monthly = "monthly",
        .weekly = "weekly",
    };
};
