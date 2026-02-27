pub const LongTermPricingType = enum {
    one_year,
    three_year,
    one_month,

    pub const json_field_names = .{
        .one_year = "ONE_YEAR",
        .three_year = "THREE_YEAR",
        .one_month = "ONE_MONTH",
    };
};
