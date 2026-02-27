/// Information needed to clear the timer.
pub const ClearTimerAction = struct {
    /// The name of the timer to clear.
    timer_name: []const u8,

    pub const json_field_names = .{
        .timer_name = "timerName",
    };
};
