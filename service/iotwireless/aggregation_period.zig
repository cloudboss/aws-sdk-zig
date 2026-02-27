pub const AggregationPeriod = enum {
    one_hour,
    one_day,
    one_week,

    pub const json_field_names = .{
        .one_hour = "OneHour",
        .one_day = "OneDay",
        .one_week = "OneWeek",
    };
};
