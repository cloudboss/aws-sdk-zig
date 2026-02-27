pub const TermLength = enum {
    one_year,
    three_year,

    pub const json_field_names = .{
        .one_year = "ONE_YEAR",
        .three_year = "THREE_YEAR",
    };
};
