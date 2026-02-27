pub const TimeGranularity = enum {
    year,
    quarter,
    month,
    week,
    day,
    hour,
    minute,
    second,
    millisecond,

    pub const json_field_names = .{
        .year = "YEAR",
        .quarter = "QUARTER",
        .month = "MONTH",
        .week = "WEEK",
        .day = "DAY",
        .hour = "HOUR",
        .minute = "MINUTE",
        .second = "SECOND",
        .millisecond = "MILLISECOND",
    };
};
