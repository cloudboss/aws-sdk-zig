pub const ReportFrequencyType = enum {
    day,
    week,
    month,
    one_time,

    pub const json_field_names = .{
        .day = "DAY",
        .week = "WEEK",
        .month = "MONTH",
        .one_time = "ONE_TIME",
    };
};
