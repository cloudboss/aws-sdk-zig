pub const TermInYears = enum {
    one_year,
    three_years,

    pub const json_field_names = .{
        .one_year = "ONE_YEAR",
        .three_years = "THREE_YEARS",
    };
};
