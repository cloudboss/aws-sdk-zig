pub const ValidityType = enum {
    days,
    months,
    years,

    pub const json_field_names = .{
        .days = "DAYS",
        .months = "MONTHS",
        .years = "YEARS",
    };
};
