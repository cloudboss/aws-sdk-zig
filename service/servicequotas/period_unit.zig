pub const PeriodUnit = enum {
    microsecond,
    millisecond,
    second,
    minute,
    hour,
    day,
    week,

    pub const json_field_names = .{
        .microsecond = "MICROSECOND",
        .millisecond = "MILLISECOND",
        .second = "SECOND",
        .minute = "MINUTE",
        .hour = "HOUR",
        .day = "DAY",
        .week = "WEEK",
    };
};
