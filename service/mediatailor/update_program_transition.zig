/// Program transition configuration.
pub const UpdateProgramTransition = struct {
    /// The duration of the live program in seconds.
    duration_millis: ?i64,

    /// The date and time that the program is scheduled to start, in epoch
    /// milliseconds.
    scheduled_start_time_millis: ?i64,

    pub const json_field_names = .{
        .duration_millis = "DurationMillis",
        .scheduled_start_time_millis = "ScheduledStartTimeMillis",
    };
};
