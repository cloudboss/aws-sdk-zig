pub const QuotaPeriodType = enum {
    day,
    week,
    month,

    pub const json_field_names = .{
        .day = "DAY",
        .week = "WEEK",
        .month = "MONTH",
    };
};
