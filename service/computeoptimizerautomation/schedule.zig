/// Configuration for scheduling when automation rules should execute, including
/// timing and execution windows.
pub const Schedule = struct {
    /// The time window in minutes during which the automation rule can start
    /// implementing recommended actions.
    execution_window_in_minutes: ?i32 = null,

    /// The expression that defines when the schedule runs. `cron` expression is
    /// supported. A `cron` expression consists of six fields separated by white
    /// spaces: (`minutes` `hours` `day_of_month` `month` `day_of_week` `year`)
    ///
    /// You can schedule rules to run at most once per day. Your cron expression
    /// must use specific values (not wildcards) for the minutes and hours fields.
    /// For example: (`30 12 * * *`) runs daily at 12:30 PM UTC.
    schedule_expression: ?[]const u8 = null,

    /// The timezone to use when interpreting the schedule expression.
    schedule_expression_timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_window_in_minutes = "executionWindowInMinutes",
        .schedule_expression = "scheduleExpression",
        .schedule_expression_timezone = "scheduleExpressionTimezone",
    };
};
