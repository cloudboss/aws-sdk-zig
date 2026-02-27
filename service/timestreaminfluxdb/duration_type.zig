pub const DurationType = enum {
    hours,
    minutes,
    seconds,
    milliseconds,
    days,

    pub const json_field_names = .{
        .hours = "HOURS",
        .minutes = "MINUTES",
        .seconds = "SECONDS",
        .milliseconds = "MILLISECONDS",
        .days = "DAYS",
    };
};
