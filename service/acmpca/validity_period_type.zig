pub const ValidityPeriodType = enum {
    end_date,
    absolute,
    days,
    months,
    years,

    pub const json_field_names = .{
        .end_date = "END_DATE",
        .absolute = "ABSOLUTE",
        .days = "DAYS",
        .months = "MONTHS",
        .years = "YEARS",
    };
};
