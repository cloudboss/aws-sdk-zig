pub const PeriodUnit = enum {
    hours,
    days,
    weeks,
    months,

    pub const json_field_names = .{
        .hours = "HOURS",
        .days = "DAYS",
        .weeks = "WEEKS",
        .months = "MONTHS",
    };
};
