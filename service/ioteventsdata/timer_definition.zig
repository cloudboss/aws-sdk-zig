/// The new setting of a timer.
pub const TimerDefinition = struct {
    /// The name of the timer.
    name: []const u8,

    /// The new setting of the timer (the number of seconds before the timer
    /// elapses).
    seconds: i32,

    pub const json_field_names = .{
        .name = "name",
        .seconds = "seconds",
    };
};
