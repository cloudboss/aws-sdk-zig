pub const RetentionIntervalUnitValues = enum {
    days,
    weeks,
    months,
    years,

    pub const json_field_names = .{
        .days = "DAYS",
        .weeks = "WEEKS",
        .months = "MONTHS",
        .years = "YEARS",
    };
};
