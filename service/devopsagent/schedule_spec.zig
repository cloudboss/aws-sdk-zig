const CronSchedule = @import("cron_schedule.zig").CronSchedule;
const TimeRangeSchedule = @import("time_range_schedule.zig").TimeRangeSchedule;

/// Structured schedule specification. Select exactly one schedule form.
pub const ScheduleSpec = union(enum) {
    /// Runs on an EventBridge cron or rate cadence
    cron: ?CronSchedule,
    /// Runs within a recurring time-of-day window
    time_range: ?TimeRangeSchedule,

    pub const json_field_names = .{
        .cron = "cron",
        .time_range = "timeRange",
    };
};
