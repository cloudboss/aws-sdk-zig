/// The time.
pub const Time = struct {
    /// The time of day in 24-hour format (00:00).
    time_of_day: []const u8,

    /// The timezone.
    timezone: []const u8,

    pub const json_field_names = .{
        .time_of_day = "timeOfDay",
        .timezone = "timezone",
    };
};
