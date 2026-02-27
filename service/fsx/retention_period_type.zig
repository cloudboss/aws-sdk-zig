pub const RetentionPeriodType = enum {
    seconds,
    minutes,
    hours,
    days,
    months,
    years,
    infinite,
    unspecified,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .minutes = "MINUTES",
        .hours = "HOURS",
        .days = "DAYS",
        .months = "MONTHS",
        .years = "YEARS",
        .infinite = "INFINITE",
        .unspecified = "UNSPECIFIED",
    };
};
