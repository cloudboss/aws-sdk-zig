pub const PaymentTerm = enum {
    three_years,
    one_year,
    five_years,

    pub const json_field_names = .{
        .three_years = "THREE_YEARS",
        .one_year = "ONE_YEAR",
        .five_years = "FIVE_YEARS",
    };
};
