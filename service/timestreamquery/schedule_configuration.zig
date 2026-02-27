/// Configuration of the schedule of the query.
pub const ScheduleConfiguration = struct {
    /// An expression that denotes when to trigger the scheduled query run. This can
    /// be a cron
    /// expression or a rate expression.
    schedule_expression: []const u8,

    pub const json_field_names = .{
        .schedule_expression = "ScheduleExpression",
    };
};
