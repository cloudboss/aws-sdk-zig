/// Contains the schedule expression and time-range offsets that define when a
/// scheduled query runs and what time range each execution covers.
pub const ScheduleConfiguration = struct {
    /// The offset, in seconds, before the scheduled execution time at which the
    /// query time range ends. Must be non-negative and less than `StartTimeOffset`.
    /// The default is 0.
    end_time_offset: ?i64 = null,

    /// The schedule expression that defines how often the underlying CloudWatch
    /// Logs scheduled query runs. Specify a `rate()` expression, for example
    /// `rate(5 minutes)`.
    schedule_expression: []const u8,

    /// The offset, in seconds, before the scheduled execution time at which the
    /// query time range begins. For example, an offset of 360 (6 minutes) on a
    /// query running at 12:05:00 starts the query time range at 11:59:00.
    start_time_offset: i64,

    pub const json_field_names = .{
        .end_time_offset = "EndTimeOffset",
        .schedule_expression = "ScheduleExpression",
        .start_time_offset = "StartTimeOffset",
    };
};
