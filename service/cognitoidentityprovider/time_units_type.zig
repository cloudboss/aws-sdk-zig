pub const TimeUnitsType = enum {
    seconds,
    minutes,
    hours,
    days,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .minutes = "MINUTES",
        .hours = "HOURS",
        .days = "DAYS",
    };
};
