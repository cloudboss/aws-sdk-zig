pub const AutocommitPeriodType = enum {
    minutes,
    hours,
    days,
    months,
    years,
    none,

    pub const json_field_names = .{
        .minutes = "MINUTES",
        .hours = "HOURS",
        .days = "DAYS",
        .months = "MONTHS",
        .years = "YEARS",
        .none = "NONE",
    };
};
