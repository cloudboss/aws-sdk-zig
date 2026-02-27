pub const CommitmentDuration = enum {
    one_month,
    six_months,

    pub const json_field_names = .{
        .one_month = "ONE_MONTH",
        .six_months = "SIX_MONTHS",
    };
};
