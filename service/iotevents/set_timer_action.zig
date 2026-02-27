/// Information needed to set the timer.
pub const SetTimerAction = struct {
    /// The duration of the timer, in seconds. You can use a string expression that
    /// includes
    /// numbers, variables (`$variable.`), and input values
    /// (`$input..`) as the duration. The range of
    /// the duration is 1-31622400 seconds. To ensure accuracy, the minimum duration
    /// is 60 seconds.
    /// The evaluated result of the duration is rounded down to the nearest whole
    /// number.
    duration_expression: ?[]const u8,

    /// The number of seconds until the timer expires. The minimum value is 60
    /// seconds to ensure
    /// accuracy. The maximum value is 31622400 seconds.
    seconds: ?i32,

    /// The name of the timer.
    timer_name: []const u8,

    pub const json_field_names = .{
        .duration_expression = "durationExpression",
        .seconds = "seconds",
        .timer_name = "timerName",
    };
};
