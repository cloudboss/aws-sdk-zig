const ScheduleState = @import("schedule_state.zig").ScheduleState;

/// A scheduling object using a `cron` statement to schedule an event.
pub const Schedule = struct {
    /// A `cron` expression used to specify the schedule (see [Time-Based Schedules
    /// for Jobs and
    /// Crawlers](https://docs.aws.amazon.com/glue/latest/dg/monitor-data-warehouse-schedule.html). For example, to run
    /// something every day at 12:15 UTC, you would specify:
    /// `cron(15 12 * * ? *)`.
    schedule_expression: ?[]const u8,

    /// The state of the schedule.
    state: ?ScheduleState,

    pub const json_field_names = .{
        .schedule_expression = "ScheduleExpression",
        .state = "State",
    };
};
