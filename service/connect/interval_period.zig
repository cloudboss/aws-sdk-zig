pub const IntervalPeriod = enum {
    fifteen_min,
    thirty_min,
    hour,
    day,
    week,
    total,

    pub const json_field_names = .{
        .fifteen_min = "FIFTEEN_MIN",
        .thirty_min = "THIRTY_MIN",
        .hour = "HOUR",
        .day = "DAY",
        .week = "WEEK",
        .total = "TOTAL",
    };
};
