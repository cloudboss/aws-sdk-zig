pub const TopicTimeGranularity = enum {
    second,
    minute,
    hour,
    day,
    week,
    month,
    quarter,
    year,

    pub const json_field_names = .{
        .second = "SECOND",
        .minute = "MINUTE",
        .hour = "HOUR",
        .day = "DAY",
        .week = "WEEK",
        .month = "MONTH",
        .quarter = "QUARTER",
        .year = "YEAR",
    };
};
