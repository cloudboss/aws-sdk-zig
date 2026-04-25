const SchedulePeriod = @import("schedule_period.zig").SchedulePeriod;
const ScheduleState = @import("schedule_state.zig").ScheduleState;

/// Defines the schedule for a scheduled report, including the cron expression,
/// time zone, active period, and the schedule state.
pub const ScheduleConfig = struct {
    /// The schedule expression that specifies when to trigger the scheduled report
    /// run. This value must be a cron expression consisting of six fields separated
    /// by white spaces: `cron(minutes hours day_of_month month day_of_week year)`.
    schedule_expression: ?[]const u8 = null,

    /// The time zone for the schedule expression, for example, `UTC`.
    schedule_expression_time_zone: ?[]const u8 = null,

    /// The time period during which the schedule is active.
    schedule_period: ?SchedulePeriod = null,

    /// The state of the schedule. `ENABLED` means the scheduled report runs
    /// according to its schedule expression. `DISABLED` means the scheduled report
    /// is paused and will not run until re-enabled.
    state: ?ScheduleState = null,

    pub const json_field_names = .{
        .schedule_expression = "scheduleExpression",
        .schedule_expression_time_zone = "scheduleExpressionTimeZone",
        .schedule_period = "schedulePeriod",
        .state = "state",
    };
};
