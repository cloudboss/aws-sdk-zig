pub const TtlDurationUnit = enum {
    seconds,
    minutes,
    hours,
    days,
    weeks,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .minutes = "MINUTES",
        .hours = "HOURS",
        .days = "DAYS",
        .weeks = "WEEKS",
    };
};
