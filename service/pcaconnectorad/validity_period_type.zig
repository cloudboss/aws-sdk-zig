pub const ValidityPeriodType = enum {
    hours,
    days,
    weeks,
    months,
    years,

    pub const json_field_names = .{
        .hours = "HOURS",
        .days = "DAYS",
        .weeks = "WEEKS",
        .months = "MONTHS",
        .years = "YEARS",
    };
};
