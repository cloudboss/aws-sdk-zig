const DailySchedule = @import("daily_schedule.zig").DailySchedule;
const MonthlySchedule = @import("monthly_schedule.zig").MonthlySchedule;
const WeeklySchedule = @import("weekly_schedule.zig").WeeklySchedule;

/// Specifies the recurrence pattern for running a classification job.
pub const JobScheduleFrequency = struct {
    /// Specifies a daily recurrence pattern for running the job.
    daily_schedule: ?DailySchedule,

    /// Specifies a monthly recurrence pattern for running the job.
    monthly_schedule: ?MonthlySchedule,

    /// Specifies a weekly recurrence pattern for running the job.
    weekly_schedule: ?WeeklySchedule,

    pub const json_field_names = .{
        .daily_schedule = "dailySchedule",
        .monthly_schedule = "monthlySchedule",
        .weekly_schedule = "weeklySchedule",
    };
};
